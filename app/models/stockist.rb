class Stockist < ApplicationRecord
  belongs_to :shop
  before_save :set_country

  def set_country
  end
end
