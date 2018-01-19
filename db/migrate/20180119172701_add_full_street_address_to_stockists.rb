class AddFullStreetAddressToStockists < ActiveRecord::Migration[5.1]
  def change
    add_column :stockists, :full_street_address, :string
  end
end
