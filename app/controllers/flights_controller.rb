class FlightsController < ApplicationController

  def index
    @search = Flight.get_confirm.ransack params[:q]
    @search.sorts = 'code asc' if @search.sorts.empty?
    @flights = @search.result.includes(:plane, :start_place, :end_place).paginate page: params[:page], per_page: 8
  end

  def show
    @flight = Flight.find params[:id]
  end
end
