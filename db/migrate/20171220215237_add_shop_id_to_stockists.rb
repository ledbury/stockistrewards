class AddShopIdToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :shop_id, :integer
  end
end
