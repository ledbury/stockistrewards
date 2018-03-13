class AddCalculatedAtToRewardPeriods < ActiveRecord::Migration[5.1]
  def change
    add_column :reward_periods, :calculated_at, :datetime
  end
end
