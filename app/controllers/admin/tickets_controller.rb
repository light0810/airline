class Admin::TicketsController < ApplicationController
  before_action :require_admin
  before_action :load_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @search = Ticket.search params[:q]
    @search.sorts = 'id asc' if @search.sorts.empty?
    @tickets = @search.result.includes(:flight, :user, :plane).paginate page: params[:page], per_page: 10
    @block_tickets = Ticket.get_by_status 0
    @sale_tickets = Ticket.get_by_status 1
    @own_tickets = Ticket.get_by_status 2
  end

  def edit
  end

  def update
    if @ticket.update_attributes ticket_params
      flash[:success] = "Sửa thành công"
      redirect_to admin_tickets_path
    else
      flash[:danger] = "Sửa thất bại"
      render "edit"
    end
  end

  def destroy
    if @ticket.destroy
      flash[:success] = "Xóa thành công"
      redirect_to admin_tickets_path
    else
      flash[:danger] = "Xóa thất bại"
      redirect_to admin_tickets_path
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit :location, :status, :level
  end

  def load_ticket
    @ticket = Ticket.find params[:id]
  end
end
