class Admin::PlacesController < ApplicationController
  before_action :require_admin
  before_action :load_place, only: [:show, :edit, :update, :destroy]

  def index
    @search = Place.search params[:q]
    @search.sorts = 'city asc' if @search.sorts.empty?
    @places = @search.result.paginate page: params[:page], per_page: 10
  end

  def show
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new place_params
    if @place.save
      flash[:success] = "Tạo thành công"
      redirect_to [:admin, @place]
    else
      flash[:danger] = "Tạo thất bại"
      render "new"
    end
  end

  def edit
  end

  def update
    if @place.update_attributes place_params
      flash[:success] = "Sửa thành công"
      redirect_to [:admin, @place]
    else
      flash[:danger] = "Sửa thất bại"
      render "edit"
    end
  end

  def destroy
    if @place.destroy
      flash[:success] = "Xóa thành công"
      redirect_to admin_places_path
    else
      flash[:danger] = "Xóa thất bại"
      redirect_to admin_places_path
    end
  end

  private
  def place_params
    params.require(:place).permit :city, :country
  end

  def load_place
    @place = Place.find params[:id]
  end
end
