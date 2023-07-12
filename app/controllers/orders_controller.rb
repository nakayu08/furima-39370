class OrdersController < ApplicationController
  def index
    @order_from =OrderFrom.new
  end

  def create
    @order_from =OrderFrom.new(order_params)
    if @order_from.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order_from).permit(:post_code, :prefecture_id, :municipalities, :address, :building_name, :telephone_number,:item_id).merge(user_id: current_user.id)
  end
