class ApplicationController < ShopifyApp::AuthenticatedController
  protect_from_forgery with: :exception
  include ShopifyApp::LoginProtection

  private

  def get_shop
    s = ShopifyAPI::Shop.current
    @shop = Shop.find_by(shopify_domain: s.myshopify_domain)
    @shopify_domain = s.domain.split('.')[0]
  end

end
