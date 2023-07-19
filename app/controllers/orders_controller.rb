class OrdersController < ApplicationController
  before_action :authenticate_user!,only:[:index]

  def index
    @item = Item.find(params[:item_id])
    @order_from =OrderFrom.new

    if @item.user_id == current_user.id || @item.order.present?
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_from =OrderFrom.new(order_params)
    if @order_from.valid?
      pay_item
      
      @order_from.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_from).permit(:post_code, :prefecture_id, :municipalities, :address, :building_name, :telephone_number).merge(user_id: current_user.id,item_id: @item.id).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end