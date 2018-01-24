class Reward < ApplicationRecord
  belongs_to :stockist
  belongs_to :order
end
