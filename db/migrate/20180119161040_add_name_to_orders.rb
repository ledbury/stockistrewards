class AddNameToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :name, :string
  end
end
