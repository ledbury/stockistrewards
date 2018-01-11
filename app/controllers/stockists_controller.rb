class StockistsController < ApplicationController
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
    @stockist = Stockist.find(params{})
  end

  private

  def stockist_params
    params.require(:stockist).permit(:shop_id, :name, :address_1, :address_2, :city, :postcode, :order_radius, :reward_percentage)
  end

  def sync_products
    sync_response = sync_logic(page: params[:api_page].to_i)
  end

  def sync_logic(**api_params)
    count = 0
    products = ShopifyAPI::Product.find(:all, params: api_params)
    products.each do |product|
      product_record = Product.find_or_initialize_by({shop_id: @shop.id, shopify_id: product.id})
      updates = false

      if product_record.title != product.title
        product_record.title = product.title
        updates = true
      end

      if product_record.handle != product.handle
        product_record.handle = product.handle
      end

      if updates && product_record.save!
        count = count + 1
      end

      product_video = ProductVideo.where("video_file_name like ? AND shopify_domain = ?", "%#{product_record.handle}%", @shopify_domain).first

      if product_video.present? && product_video.product_id != product_record.id
        product_video.product_id = product_record.id
        product_video.save!
      end
    end
    { count: count, products: Product.where(shop_id: @shop.id), passed_params: api_params }
  end

end
