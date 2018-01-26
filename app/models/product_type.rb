class ProductType < ApplicationRecord
  has_and_belongs_to_many :stockists
  belongs_to :shop
end
