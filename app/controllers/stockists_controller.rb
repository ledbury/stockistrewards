class StockistsController < ShopifyApp::AuthenticatedController
  before_action :get_shop

  def index
    @stockists = Stockist.where(shop: @shop)
  end

  def new
    @stockist = Stockist.new
    @countries = ['US']
    @states = ISO3166::Country.new(@countries[0]).states
  end

  def create
    @stockist = Stockist.new(stockist_params)
    if @stockist.save
      redirect_to '/stockists' and return
    else
      logger.info @stockist.errors.inspect
    end
  end

  def edit
    @stockist = Stockist.find(params[:id])
  end

  def sync_orders
    sync_response = sync_logic(page: params[:api_page].to_i)
    respond_to do |format|
      format.json { render json: sync_response }
    end
  end

  private

  def sync_logic(**api_params)
    count = 0
    orders = ShopifyAPI::Order.find(:all, params: api_params)
    orders.each do |product|
      order_record = Order.find_or_initialize_by({shop_id: @shop.id, shopify_id: order.id})

      if order_record.save!
        count = count + 1
      end
    end
    { count: count, products: Order.where(shop_id: @shop.id), passed_params: api_params }
  end

  def stockist_params
    params.require(:stockist).permit(:shop_id, :name, :address_1, :address_2, :city, :postcode, :order_radius, :reward_percentage)
  end

  def get_shop
    s = ShopifyAPI::Shop.current
    @shop = Shop.find_by(shopify_domain: s.myshopify_domain)
    @shopify_domain = s.domain.split('.')[0]
  end
end
