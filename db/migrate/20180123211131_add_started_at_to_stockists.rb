class AddStartedAtToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :started_at, :datetime
  end
end
