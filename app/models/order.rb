class Order < ApplicationRecord
  belongs_to :shop
  has_many :line_items

  def sync_order(order)

    self.name = order.name
    self.total = order.total_line_items_price
    self.shipping_postcode = order.customer.default_address.zip
    self.customer_email = order.customer.email
    self.customer_name = order.customer.first_name+' '+order.customer.last_name
    self.created_at = order.processed_at.nil? ? order.created_at : order.processed_at
    self.full_street_address =
      "#{order.shipping_address.address1} #{order.shipping_address.address2}, #{order.customer.default_address.city}, #{order.shipping_address.province_code} #{order.shipping_address.zip}"
    self.latitude = order.shipping_address.latitude
    self.longitude = order.shipping_address.longitude

  end

  private

end
