class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = current_user.tickets.order :id
  end

  def update
    @ticket = Ticket.find params[:id]
    @cart = @ticket.cart
    unless @cart.status == "Completed"
      @ticket.update_attributes cart_id: nil
      if @cart.tickets.count == 0
        @cart.update_attributes user_id: nil
      end
    end
    redirect_to :back
  end
end
