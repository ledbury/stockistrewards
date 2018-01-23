class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :stockists
  has_many :orders

  def sync_orders
    order_count = 0
    orders = 0
    puts "INFO: sync_orders FOR STOCKIST: #{self.inspect}"

    orders = get_orders_since_last_id
    while orders.count > 0
      orders.each do |order|
        logger.info order.inspect
        order_record = Order.find_or_initialize_by({shop_id: self.id, shopify_id: order.id})
        next if defined?(order.customer).nil?
        order_record.sync_order(order)
        if order_record.save
          order_count = order_count + 1
        else
          logger.info "ERROR: ORDER NOT SAVED: "+order.errors.inspect
        end
      end
      orders = get_orders_since_last_id
    end

  end

  def calculate_rewards
    self.stockists.each do |stockist|
      puts "INFO: CALCULATING REWARDS FOR STOCKIST: #{stockist.inspect}"
      stockist.calculate_rewards
    end
  end

  private

  def get_orders_since_last_id
    sid = Order.maximum(:shopify_id)
    orders = ShopifyAPI::Order.find(:all, params: {since_id: sid, order: 'created_at ASC' })
  end

end
