class BuyTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flight = Flight.find params[:flight_id]
    if @flight.confirm?
      @other_tickets = @flight.tickets.get_by_level 0
      @type1_tickets = @flight.tickets.get_by_level 1
      @type2_tickets = @flight.tickets.get_by_level 2
      @type3_tickets = @flight.tickets.get_by_level 3
    end
  end

  def create
    @cart = Cart.create user_id: current_user.id
    @ticket = Ticket.find params[:ticket_id]
    if @ticket.sale?
      @ticket.update_attributes cart_id: @cart.id
      flash[:success] = "Đặt vé thành công."
    else
      flash[:danger] = "Vé vừa được đặt hoặc vừa bị khóa. Vui lòng chọn vé khác"
    end
    redirect_to :back
  end
end
