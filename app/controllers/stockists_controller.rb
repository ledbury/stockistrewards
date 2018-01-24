class StockistsController < ShopifyApp::AuthenticatedController
  before_action :get_shop

  def index
    @stockists = Stockist.where(shop: @shop)
    OrderSyncJob.perform_later(@shop)
    if @stockists.count == 0
      redirect_to action: 'new'
    end
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

  def show
    @stockist = Stockist.find(params[:id])
  end

  def edit
    @stockist = Stockist.find(params[:id])
  end

  def destroy
    @stockist = Stockist.find(params[:id])
    @stockist.destroy
    redirect_to action: "index"
  end

  def get_total_orders
    count = get_order_count
    respond_to do |format|
      format.json { render json: { count: count } }
    end
  end

  private

  def stockist_params
    params.require(:stockist).permit(:shop_id, :name, :address_1, :address_2, :city, :state, :postcode, :order_radius, :reward_percentage)
  end

  def get_shop
    s = ShopifyAPI::Shop.current
    @shop = Shop.find_by(shopify_domain: s.myshopify_domain)
    @shopify_domain = s.domain.split('.')[0]
  end

  def get_order_count
    ShopifyAPI::Order.count
  end

end
