class Order < ApplicationRecord
  belongs_to :shop
  has_many :line_items

  geocoded_by :full_street_address
  after_validation :geocode

  def self.sync_logic(page, shop)
    order_count = 0
    orders = ShopifyAPI::Order.find(:all, params: {page: page})
    orders.each do |order|

      logger.info order.inspect
      order_record = Order.find_or_initialize_by({shop_id: shop.id, shopify_id: order.id})
      order_record.sync_order order

      # line item


      order_record.total = order.subtotal_price
      if order_record.save!
        order_count = order_count + 1
      end
    end
    { count: order_count, orders: Order.where(shop_id: shop.id), passed_params: {page: page} }
  end


  def sync_order(order)

    self.name = order.name
    self.shipping_postcode = order.customer.default_address.zip
    self.customer_email = order.customer.email
    self.customer_name = order.customer.first_name+' '+order.customer.last_name

    self.full_street_address =

      "#{order.customer.default_address.address1}, #{order.customer.default_address.address2}, #{order.customer.default_address.city}, #{order.customer.default_address.province_code} #{order.customer.default_address.zip}"
  end

  private

end
