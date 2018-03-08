class CalculationsController < ApplicationController

  def calculate
    sd = params[:reward_period][:start_date]
    fail
    ed = params[:reward_period][:end_date]
    if sd > ed
      flash[:error] = 'Start Date is after End Date'
    else
      flash[:notice] = 'Recalculating for new period...'

      rp = RewardPeriod.new
      rp.start_date = sd
      rp.end_date = ed
      rp.save

    end

    OrderSyncJob.perform_later(@shop)
    redirect_to '/stockists' and return


  end

end
