class AddRewardAmountToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :reward_amount, :float
  end
end
