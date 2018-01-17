class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :stockists
  has_many :orders
end
