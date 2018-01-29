class AddRadiusUnitsToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :units, :string
  end
end
