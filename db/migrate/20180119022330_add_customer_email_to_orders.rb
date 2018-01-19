class AddCustomerEmailToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :customer_email, :string
  end
end
