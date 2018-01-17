class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :shopify_id
      t.integer :product_id

      t.timestamps
    end
  end
end
