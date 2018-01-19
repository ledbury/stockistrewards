class Stockist < ApplicationRecord
  belongs_to :shop
  has_many :orders
  before_save :set_country, :set_full_address

  geocoded_by :full_street_address
  after_validation :geocode

  def is_order_eligible? order
    unless self.postcode.nil? or order.shipping_postcode.nil?
      order.s

    end
    false
  end

  def reward_for_order

  end

  def get_total_reward

  end

  private

  def set_country
  end

  def set_full_address
    self.set_full_address = "#{self.address_1}, #{self.address_2}, #{self.city}, #{self.state} #{self.postcode}"
  end

end
