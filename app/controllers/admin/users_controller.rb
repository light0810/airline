class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @search = User.search params[:q]
    @search.sorts = 'id asc' if @search.sorts.empty?
    @users = @search.result.paginate page: params[:page], per_page: 10
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Sửa thành công"
      redirect_to [:admin, @user]
    else
      flash[:danger] = "Sửa thất bại"
      render "edit"
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Xóa thành công"
      redirect_to admin_users_path
    else
      flash[:danger] = "Xóa thất bại"
      redirect_to admin_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :address, :passport, :credit_card, :gender, :birthday, :badge
  end

  def load_user
    @user = User.find params[:id]
  end
end
