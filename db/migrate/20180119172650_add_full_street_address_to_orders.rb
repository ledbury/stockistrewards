class AddFullStreetAddressToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :full_street_address, :string
  end
end
