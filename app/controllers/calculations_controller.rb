class CalculationsController < ApplicationController

  def calculate
    sd = params[:reward_period][:start_date]
    ed = params[:reward_period][:end_date]
    sdd = Date.strptime(sd, '%m/%d/%Y')
    edd = Date.strptime(ed, '%m/%d/%Y')
    if sdd > edd
      flash[:error] = 'Start Date is after End Date'
    else
      flash[:notice] = 'Recalculating for new period...'

      rp = RewardPeriod.new
      rp.shop_id = @shop.id
      rp.start_date = sdd
      rp.end_date = edd
      rp.save

    end

    OrderSyncJob.perform_later(@shop)

    redirect_to '/stockists' and return

  end

end
