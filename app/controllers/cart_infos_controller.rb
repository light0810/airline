class CartInfosController < ApplicationController
  protect_from_forgery except: :create

  def create
    status = params[:payment_status]
    if status == "Completed"
      @cart = Cart.find params[:invoice]
      @cart.update_attributes notification_params: params, status: params[:payment_status], transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end
end
