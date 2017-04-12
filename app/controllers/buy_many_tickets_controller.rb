class BuyManyTicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flight = Flight.find params[:flight_id]
  end

  def create
    @cart = Cart.create user_id: current_user.id
    @flight = Flight.find params[:flight_id]
    @tickets = @flight.tickets.get_by_status 1
    if @tickets.count == 0 || !@flight.confirm?
      flash[:alert] = "Vé chưa được phát hành hoặc có trục trặc hệ thống."
      redirect_to :back
    else
      @number_ticket_1 = params[:number_ticket_1].to_i
      @number_ticket_2 = params[:number_ticket_2].to_i
      @number_ticket_3 = params[:number_ticket_3].to_i
      @number_ticket_other = params[:number_ticket_other].to_i

      if @number_ticket_1 == 0 && @number_ticket_2 == 0 && @number_ticket_3 == 0 && @number_ticket_other == 0
        flash[:alert] = "Chưa đặt vé"
        redirect_to :back
      elsif @number_ticket_1 > @flight.number_ticket_1
        flash[:alert] = "Vé hạng 1 trên máy bay không đủ. Chọn loại vé khác."
        redirect_to :back
      elsif @number_ticket_2 > @flight.number_ticket_2
        flash[:alert] = "Vé hạng 2 trên máy bay không đủ. Chọn loại vé khác."
        redirect_to :back
      elsif @number_ticket_3 > @flight.number_ticket_3
        flash[:alert] = "Vé hạng 3 trên máy bay không đủ. Chọn loại vé khác."
        redirect_to :back
      elsif @number_ticket_other > @flight.number_ticket_other
        flash[:alert] = "Vé hạng khác trên máy bay không đủ. Chọn loại vé khác."
        redirect_to :back
      else
        if @number_ticket_1 != 0
          @tickets_1 = @tickets.get_by_level(1).sample(@number_ticket_1)
          @tickets_1.each do |ticket|
            ticket.update_attributes cart_id: @cart.id
          end
        end

        if @number_ticket_2 != 0
          @tickets_2 = @tickets.get_by_level(2).sample(@number_ticket_2)
          @tickets_2.each do |ticket|
            ticket.update_attributes cart_id: @cart.id
          end
        end

        if @number_ticket_3 != 0
          @tickets_3 = @tickets.get_by_level(3).sample(@number_ticket_3)
          @tickets_3.each do |ticket|
            ticket.update_attributes cart_id: @cart.id
          end
        end

        if @number_ticket_other != 0
          @tickets_other = @tickets.get_by_level(0).sample(@number_ticket_other)
          @tickets_other.each do |ticket|
            ticket.update_attributes cart_id: @cart.id
          end
        end
        flash[:success] = "Đặt vé thành công."
        redirect_to :back
      end
    end  
  end
end
