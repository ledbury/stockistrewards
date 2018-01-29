class ApplicationController < ShopifyApp::AuthenticatedController
  before_action :get_shop
  protect_from_forgery with: :exception

  private

  def get_shop
    s = ShopifyAPI::Shop.current
    @shop = Shop.find_by(shopify_domain: s.myshopify_domain)
    @shopify_domain = s.domain.split('.')[0]
  end

end
