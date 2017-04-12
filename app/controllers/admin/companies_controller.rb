class Admin::CompaniesController < ApplicationController
  before_action :require_admin
  before_action :load_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all.paginate page: params[:page], per_page: 10
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_params
    if @company.save
      redirect_to [:admin, @company]
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @company.update_attributes company_params
      flash[:success] = "Sửa thành công"
      redirect_to [:admin, @company]
    else
      flash[:danger] = "Sửa thất bại"
      render "edit"
    end
  end

  def destroy
    if @company.destroy
      flash[:success] = "Xóa thành công"
      redirect_to admin_companys_path
    else
      flash[:danger] = "Xóa thất bại"
      redirect_to admin_companys_path
    end
  end

  private
  def company_params
    params.require(:company).permit :name
  end

  def load_company
    @company = Company.find params[:id]
  end
end
