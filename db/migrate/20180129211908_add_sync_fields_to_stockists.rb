class AddSyncFieldsToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :synced_at, :datetime
    add_column :stockists, :calculated_at, :datetime
  end
end
