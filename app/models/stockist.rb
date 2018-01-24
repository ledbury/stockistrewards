class Stockist < ApplicationRecord
  belongs_to :shop
  has_many :orders
  has_many :rewards
  has_and_belongs_to_many :product_types
  before_save :set_country, :set_full_address, :geocode, :set_start_date
  geocoded_by :full_street_address

  def calculate_rewards
    count = 0
    Order.where({shop_id: self.shop_id}).each do |order|
      if is_reward_eligible?(order)
        puts "#{order.shopify_id} is Eligible!"
        reward = Reward.find_or_initialize_by({stockist_id: self.id, order_id: order.id})
        reward.amount = self.reward_for_order(order)
        if reward.save
          count = count + 1
        end
      end
    end
    count
  end

  def is_reward_eligible?(order)
    unless self.latitude.blank? or order.latitude.blank?
      puts "INFO: checking eligibility for order #"+order.name+", distance is #{self.distance_to(order)}"
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
    self.rewards.sum(:amount)
  end

  def self.import_csv(shop = Shop.last)
    require 'csv'

      CSV.foreach("stockists.csv", quote_char: '"', col_sep: ',', row_sep: :auto, headers: true) do |row|
      if !row['Name'].blank?
        st = Stockist.create({shop_id: shop.id, name: row['Name'], address_1: row['Address'], city: row['City'], state: row['State'], postcode: row['ZIP']})
        st.order_radius = 10
        st.reward_percentage = 10

        # TEMPORARY
        st.started_at = Date.today - 1.month

        if st.save

        else
          logger.info "ERROR: STOCKIST failed to save: #{st.errors.inspect}"
        end
      end
    end
  end

  private

  def set_country
  end

  def set_full_address
    self.full_street_address = "#{self.address_1} #{self.address_2}, #{self.city}, #{self.state} #{self.postcode}"
  end

  def set_start_date
    self.started_at = Date.today if self.started_at.nil?
  end

end
