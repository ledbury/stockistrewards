class Order < ApplicationRecord
  belongs_to :shop
  has_many :line_items
  geocoded_by :full_street_address

  def sync_order(order)

    self.name = order.name
    self.total = order.total_line_items_price
    self.shipping_postcode = order.customer.default_address.zip
    self.customer_email = order.customer.email
    self.customer_name = order.customer.name
    self.created_at = order.processed_at.nil? ? order.created_at : order.processed_at
    self.full_street_address =
      "#{order.shipping_address.address1} #{order.shipping_address.address2},
       #{order.shipping_address.city}, #{order.shipping_address.province_code}  #{order.shipping_address.zip}"
    self.latitude = order.shipping_address.latitude
    self.longitude = order.shipping_address.longitude

    #line items
    order.line_items.each do |li|
      next unless li.product_exists
      begin
        p = ShopifyAPI::Product.find(li.product_id)
        li_record = LineItem.find_or_initialize_by({order_id: order.id, shopify_id: li.id, product_shopify_id: li.product_id, variant_shopify_id: li.variant_id})
        li_record.product_title = p.title
        li_record.product_type = p.product_type
        li_record.save
      rescue
        puts "INFO: shopify product not found with id: #{li.inspect}"
      end
    end
  end

  private

end
