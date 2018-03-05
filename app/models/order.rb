class Order < ApplicationRecord
  belongs_to :shop
  has_many :line_items
  geocoded_by :full_street_address

  def sync_order(order)

    self.name = order.name
    self.first_name = order.shipping_address.first_name
    self.last_name = order.shipping_address.last_name
    self.phone = order.shipping_address.phone
    self.total = order.total_line_items_price
    self.shipping_postcode = order.customer.default_address.zip
    self.customer_email = order.customer.email
    if !order.customer.first_name.nil? && !order.customer.last_name.nil?
      self.customer_name = order.customer.first_name+' '+order.customer.last_name
    elsif !order.customer.default_address.nil?
      if !order.customer.default_address.name.nil?
        self.customer_name = order.customer.default_address.name
      end
    end
    self.created_at = order.processed_at.nil? ? order.created_at : order.processed_at
    self.full_street_address =
      "#{order.shipping_address.address1} #{order.shipping_address.address2},
       #{order.shipping_address.city}, #{order.shipping_address.province_code}  #{order.shipping_address.zip}"
    self.latitude = order.shipping_address.latitude
    self.longitude = order.shipping_address.longitude


    #line items
    puts "order.line_items ="+order.line_items.inspect
    order.line_items.each do |li|
      li_record = LineItem.find_or_initialize_by({order_id: self.id, shopify_id: li.id, product_shopify_id: li.product_id, variant_shopify_id: li.variant_id})
      puts li_record

      li_record.sync_line_item(li)
      if li_record.save
        puts "LINE ITEM CREATED: #{li.id}"
      else
        puts "ERROR: #{li_record.errors.inspect}"
      end
    end

    self.save!
  end

  private

end
