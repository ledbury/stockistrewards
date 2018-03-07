class CreateRewardPeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :reward_periods do |t|
      t.integer :shop_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
