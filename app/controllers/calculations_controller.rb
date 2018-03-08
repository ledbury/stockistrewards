class CalculationsController < ApplicationController

  def calculate
    sd = params[:reward_period][:start_date]
    ed = params[:reward_period][:end_date]
    if sd > ed
      flash[:error] = 'Start Date is after End Date'
      redirect_to '/stockists' and return
    end

    OrderSyncJob.perform_later(@shop)

  end

end
