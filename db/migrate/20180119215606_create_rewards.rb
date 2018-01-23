class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.float :amount
      t.integer :stockist_id
      t.integer :order_id

      t.timestamps
    end
  end
end
