class AddRewardPeriodIdToRewards < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :reward_period_id, :integer
  end
end
