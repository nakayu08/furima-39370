class ItemsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:edit,:destroy]
  before_action :set_item, only: [:edit, :show, :update,:destroy]
  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless @item.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id==current_user.id
      @item.destroy
      redirect_to action: :index
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :explanation, :category_id,:condition_id,:delivery_charge_id,:prefecture_id,:shipment_id,:price,:image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
