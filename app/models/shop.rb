class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :product_types
  has_many :stockists
  has_many :orders
  has_many :imports

  def sync_orders
    order_count = 0
    orders = 0
    puts "INFO: sync_orders SHOP: #{self.inspect}"

    orders = get_orders_since_last_id
    while orders.count > 0
      orders.each do |order|
        logger.info order.inspect
        order_record = Order.find_or_initialize_by({shop_id: self.id, shopify_id: order.id})
        next if defined?(order.customer).nil? || defined?(order.shipping_address).nil?
        if order_record.save
          order_record.sync_order(order)
          order_count = order_count + 1
        else
          logger.info "ERROR: ORDER NOT SAVED: "+order.errors.inspect
        end
      end
      orders = get_orders_since_last_id
    end
    self.synced_at = Time.now
  end

  def calculate_rewards
    self.stockists.each do |stockist|
      puts "INFO: CALCULATING REWARDS FOR STOCKIST: #{stockist.inspect}"
      stockist.calculate_rewards
    end
  end

  def sync_product_types_from_orders
    LineItem.select(:product_type).map{|e| e.product_type}.uniq do |sc|
      unless sc.blank?
        pt = ProductType.find_or_initialize_by({shop_id: self.id, title: sc})
        pt.handle = sc.gsub('-', ' ').downcase
        pt.save
      end
    end
  end

  def sync_product_types_by_smart_collection
    ShopifyAPI::SmartCollection.all.each do |sc|
      pt = ProductType.find_or_initialize_by({shop_id: self.id, title: sc.title})
      pt.handle = sc.handle
      pt.save
    end
  end

  private

  def earliest_start_date
    start_date = Date.today
    self.stockists.each do |s|
      st = s.started_at.blank? ? Date.today : s.started_at
      start_date = [start_date, st].min
    end
    start_date
  end

  def get_orders_since_last_id
    sid = Order.maximum(:shopify_id)
    orders = ShopifyAPI::Order.find(:all, params: {since_id: sid, order: 'created_at ASC', created_at_min: earliest_start_date })
  end

end
