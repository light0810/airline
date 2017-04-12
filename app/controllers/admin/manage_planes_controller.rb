class Admin::ManagePlanesController < ApplicationController
  before_action :require_admin

  def update
    @plane = Plane.find params[:id]
    @plane.update_attributes status: params[:status]
    flash[:alert] = "Thay đổi thành công"
    @flights = @plane.flights
    @flights.each do |flight|
      flight.update_attributes status: "not_confirm" if flight.confirm? 
    end
    redirect_to admin_planes_path
  end
end
