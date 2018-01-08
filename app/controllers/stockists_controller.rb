class StockistsController < ApplicationController
  before_action :get_shop

  def index
    @stockists = Stockist.all
  end

  def new
    @stockist = Stockist.new

  end

  def create
    @stockist = Stockist.new(stockist_params)
    if @stockist.save
      redirect_to :index and return
    else
      logger.info @stockist.errors.inspect
    end
  end

  def edit
    @stockist = Stockist.new(stockist_params)

  end

  private

  def stockist_params
    params.require(:stockist).permit(:shop_id, :name, :address_1, :address_2, :city, :postcode, :order_radius, :reward_percentage)
  end
end
