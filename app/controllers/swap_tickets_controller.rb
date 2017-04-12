class SwapTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ticket = Ticket.find params[:ticket_id]
    @flight = @ticket.flight
    if @flight.confirm?
      @type_tickets = @flight.tickets.get_by_level @ticket[:level]
    end
  end

  def update
    @ticket = Ticket.find params[:id]
    @swap_ticket = Ticket.find params[:swap_ticket_id]
    @swap_ticket.update_attributes user_id: @ticket.user_id, cart_id: @ticket.cart_id, status: @ticket[:status]
    @ticket.update_attributes user_id: nil, cart_id: nil, status: 1
    flash[:success] = "Đổi vé thành công"
    redirect_to tickets_path
  end
end
