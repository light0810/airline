class Admin::ManageFlightsController < ApplicationController
  before_action :require_admin
  before_action :check_plane_status

  def update
    @flight.update_attributes status: params[:status]
    flash[:alert] = "Thay đổi thành công"
    if params[:status] == "confirm"
      @flight.tickets.update_all status: 1
    end
    redirect_to admin_flights_path
  end

  private
  def check_plane_status
    @flight = Flight.find params[:id]
    unless @flight.plane.ready?
      flash[:danger] = "Máy bay chưa sẵn sàng."
      redirect_to admin_flights_path
    end
  end
end
