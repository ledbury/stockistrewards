class AddFieldsToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :variant_shopify_id, :bigint
    add_column :line_items, :product_shopify_id, :bigint
    add_column :line_items, :product_type, :string
    add_column :line_items, :product_name, :string
  end
end
