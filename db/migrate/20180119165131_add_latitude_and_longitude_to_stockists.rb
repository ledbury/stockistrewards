class AddLatitudeAndLongitudeToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :latitude, :float
    add_column :stockists, :longitude, :float
  end
end
