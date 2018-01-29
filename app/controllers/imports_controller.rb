class ImportsController < ApplicationController
  before_action :get_shop

  def new
    @import = Import.new
  end

  def create
    @import = Import.create(import_params)

  	if @import.save
  	  render json: { message: "success" }, :status => 200
  	else
  	  render json: { error: @import.errors.full_messages.first}, :status => 400
  	end
  end

  private
  def import_params
  	params.require(:import).permit(:shop_id, :file)
  end

end
