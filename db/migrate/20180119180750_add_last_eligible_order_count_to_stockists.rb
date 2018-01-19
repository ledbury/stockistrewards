class AddLastEligibleOrderCountToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :last_eligible_order_count, :integer
  end
end
