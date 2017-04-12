class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      upload @user
      sign_in @user, bypass: true
      flash[:success] = "Sửa thành công"
      redirect_to root_path
    else
      flash[:danger] = "Sửa thất bại"
      render :edit
    end
  end

  private
  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :address, :passport, :credit_card, :gender, :birthday, :image
  end
end
