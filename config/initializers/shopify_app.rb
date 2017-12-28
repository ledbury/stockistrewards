ShopifyApp.configure do |config|
  config.application_name = "Stockist Rewards"
  config.api_key = "4d0e6bbec4e7bdfada2b936b84cf1c1e"
  config.secret = "4d0e4260121faa516aa385c4890f874d"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
