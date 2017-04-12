class Admin::FlightsController < ApplicationController
  before_action :require_admin
  before_action :load_flight, only: [:show, :edit, :update, :destroy]

  def index
    @search = Flight.search params[:q]
    @search.sorts = 'code asc' if @search.sorts.empty?
    @flights = @search.result.includes(:plane, :start_place, :end_place).paginate page: params[:page], per_page: 10
  end

  def show
  end

  def new
    @flight = Flight.new
    @places = Place.all
    @planes = Plane.all
  end

  def create
    @flight = Flight.new flight_params_create
    if @flight.save
      flash[:success] = "Tạo thành công"
      redirect_to [:admin, @flight]
    else
      flash[:danger] = "Tạo thất bại"
      render "new"
    end
  end

  def edit
    @places = Place.all
    @planes = Plane.all
  end

  def update
    if @flight.update_attributes flight_params_update
      flash[:success] = "Sửa thành công"
      redirect_to [:admin, @flight]
    else
      flash[:danger] = "Sửa thất bại"
      render "edit"
    end
  end

  def destroy
    if @flight.destroy
      flash[:success] = "Xóa thành công"
      redirect_to admin_flights_path
    else
      flash[:danger] = "Xóa thất bại"
      redirect_to admin_flights_path
    end
  end

  private
  def flight_params_create
    params.require(:flight).permit :code, :start_time, :end_time,
      :start_place_id, :end_place_id, :cooldown_date, :plane_id,
      :number_ticket_1, :number_ticket_2, :number_ticket_3, :number_ticket_other,
      :price_ticket_1, :price_ticket_2, :price_ticket_3, :price_ticket_other
  end

  def flight_params_update
    params.require(:flight).permit :code, :start_time, :end_time,
      :start_place_id, :end_place_id, :cooldown_date, :plane_id
  end

  def load_flight
    @flight = Flight.find params[:id]
  end
end
