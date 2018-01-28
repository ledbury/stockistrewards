class AddShopIdToProductTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :product_types, :shop_id, :integer
  end
end
