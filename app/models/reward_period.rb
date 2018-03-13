class RewardPeriod < ApplicationRecord
  has_many :rewards
  belongs_to :shop
end
