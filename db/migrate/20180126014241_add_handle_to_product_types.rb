class AddHandleToProductTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :product_types, :handle, :string
  end
end
