class StockistsController < ApplicationController
  before_action :config_country, only: [:new, :edit, :update]
  before_action :shop_sync

  def index
    @stockists = Stockist.where(shop: @shop)
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
    to_javascript stockist: @stockist
  end

  def edit
    @stockist = Stockist.find(params[:id])
  end

  def update
    @stockist = Stockist.find(params[:id])
    opt = @stockist.product_types.map{|e| e.id}
    if product_type_params
      @stockist.product_types.destroy_all
      product_type_params.keys.each do |pt|
        if product_type_params[pt] == "true"
          @stockist.product_types << ProductType.find_by(handle: pt)
        end
      end
    end

    if opt.sort == @stockist.product_types.map{|e| e.id}.sort
      logger.info "INFO:  PRODUCT TYPES NOT CHANGED"
    else
      logger.info "INFO:  PRODUCT TYPES CHANGED"
      @stockist.clear_rewards
      logger.info "INFO:  REMOVED EXISTING STOCKIST REWARDS"
      shop_sync
    end

    if @stockist.update(stockist_params)
      flash[:notice] = 'Stockist Updated!'
      redirect_to action: 'index' and return
    else
      render action: 'edit'
    end
  end

  def destroy
    @stockist = Stockist.find(params[:id])
    @stockist.destroy
    redirect_to action: "index"
  end

  def export
    @stockist = Stockist.find(params[:id])
    csv = @stockist.export
    send_data csv, type: 'text/csv', disposition: "attachment"
  end

  def get_total_orders
    count = get_order_count
    respond_to do |format|
      format.json { render json: { count: count } }
    end
  end

  def zip_lookup
   sql = "select city,state from zcta where zip="+params[:zip]
   records_array = ActiveRecord::Base.connection.execute(sql)
   records_array.each do |r|
     render plain: r and return
   end
   render plain: '[]'
  end

  private

  def stockist_params
    params.require(:stockist).permit(
      :shop_id, :name, :address_1, :address_2, :city, :state, :postcode,
      :order_radius, :reward_percentage, :started_at, :restricted)
  end

  def product_type_params
    params.require(:product_type).permit(:shirt, :pants, :accessories)
  end

  def get_shop
    s = ShopifyAPI::Shop.current
    @shop = Shop.find_by(shopify_domain: s.myshopify_domain)
    @shopify_domain = s.domain.split('.')[0]
  end

  def get_order_count
    ShopifyAPI::Order.count
  end

  def config_country
    @countries = ['US']
    @states = ISO3166::Country.new(@countries[0]).states
  end

  def shop_sync
    OrderSyncJob.perform_later(@shop)
  end

end
