class CreateStockists < ActiveRecord::Migration[5.1]
  def change
    create_table :stockists do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :country
      t.string :postcode
      t.decimal :order_radius
      t.integer :reward_percentage

      t.timestamps
    end
  end
end
