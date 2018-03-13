class Reward < ApplicationRecord
  belongs_to :stockist
  belongs_to :order
  belongs_to :reward_period
end
