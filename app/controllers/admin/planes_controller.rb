class Admin::PlanesController < ApplicationController
  before_action :require_admin
  before_action :load_plane, only: [:show, :edit, :update, :destroy]

  def index
    @search = Plane.search params[:q]
    @search.sorts = 'code asc' if @search.sorts.empty?
    @planes = @search.result.includes(:company).paginate page: params[:page], per_page: 10
  end

  def show
  end

  def new
    @plane = Plane.new
    @companies = Company.all
  end

  def create
    @plane = Plane.new plane_params
    if @plane.save
      flash[:success] = "Tạo thành công"
      redirect_to [:admin, @plane]
    else
      flash[:danger] = "Tạo thất bại"
      render "new"
    end
  end

  def edit
    @companies = Company.all
  end

  def update
    if @plane.update_attributes plane_params
      flash[:success] = "Sửa thành công"
      redirect_to [:admin, @plane]
    else
      flash[:danger] = "Sửa thất bại"
      render "edit"
    end
  end

  def destroy
    if @plane.destroy
      flash[:success] = "Xóa thành công"
      redirect_to admin_planes_path
    else
      flash[:danger] = "Xóa thất bại"
      redirect_to admin_planes_path
    end
  end

  private
  def plane_params
    params.require(:plane).permit :name, :code, :company_id
  end

  def load_plane
    @plane = Plane.find params[:id]
  end
end
