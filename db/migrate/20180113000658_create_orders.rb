class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.bigint :shopify_id
      t.integer :shop_id
      t.string :customer_name
      t.string :total
      t.string :shipping_postcode

      t.timestamps
    end
  end
end
