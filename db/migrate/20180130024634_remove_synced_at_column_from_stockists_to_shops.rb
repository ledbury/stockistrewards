class RemoveSyncedAtColumnFromStockistsToShops < ActiveRecord::Migration[5.1]
  def change
    remove_column :stockists, :synced_at, :datetime
    add_column :shops, :synced_at, :datetime
  end
end
