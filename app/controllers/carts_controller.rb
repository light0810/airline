class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts.order :id
  end
end
