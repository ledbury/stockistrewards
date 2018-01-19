class AddLatitudeAndLongitudeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :latitude, :float
    add_column :orders, :longitude, :float
  end
end
