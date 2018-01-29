class LineItem < ApplicationRecord
  belongs_to :order

  def sync_line_item(line_item)

    begin
      p = ShopifyAPI::Product.find(line_item.product_id)
      self.product_title = p.title
      self.product_type = p.product_type
    rescue
      puts "INFO: shopify product not found with id: #{line_item}"
    end
  end
end
