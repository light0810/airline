class SchedulesController < ApplicationController
  def index
    @search = Flight.ransack params[:q]
    @search.sorts = 'code asc' if @search.sorts.empty?
    @flights = @search.result.includes(:plane, :start_place, :end_place).paginate page: params[:page], per_page: 10
  end
end
