class Stockist < ApplicationRecord
  belongs_to :shop
  has_many :orders
  before_save :set_country, :set_full_address, :geocode
  geocoded_by :full_street_address

  def calculate_rewards
    Order.where({shop_id: self.shop_id}).each do |order|
      if is_order_eligible? order
        puts "#{order.shopify_id} is Eligible!"
        reward = Reward.find_or_initialize_by({stockist_id: self.id, order_id: order.id})
        reward.amount = self.reward_for_order(order)
        reward.save
      end
    end
  end

  def is_order_eligible? order
    unless self.latitude.blank? or order.latitude.blank?
      if self.distance_to(order) < self.order_radius
        return true
      end
    end
    false
  end

  def reward_for_order(order)
    (order.total.to_f * self.reward_percentage.to_f) / 100.0
  end

  def total_reward_amount

  end

  private

  def set_country
  end

  def set_full_address
    self.full_street_address = "#{self.address_1} #{self.address_2}, #{self.city}, #{self.state} #{self.postcode}"
  end

end
