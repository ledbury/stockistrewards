class HomeController < ApplicationController
  before_action :get_shop

  def index
    # @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    # @webhooks = ShopifyAPI::Webhook.find(:all)
    @stockists = Stockist.where(shop: @shop)

  end


end
