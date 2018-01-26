class LineItem < ApplicationRecord
  belongs_to :order

  def sync_line_item(line_item)

    begin
      p = ShopifyAPI::Product.find(line_item.product_id)    
      li_record.product_title = p.title
      li_record.product_type = p.product_type
    rescue
      puts "INFO: shopify product not found with id: #{li.inspect}"
    end
  end
end
