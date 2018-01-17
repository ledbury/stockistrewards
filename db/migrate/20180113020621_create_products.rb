class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :shop_id
      t.bigint :shopify_id
      t.string :title
      t.string :handle

      t.timestamps
    end
  end
end
