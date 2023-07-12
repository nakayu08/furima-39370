class OrderFrom
  include ActiveModel::Model
  attr_accessor :post_code,:prefecture_id,:municipalities,:address,:building_name,:telephone_number,:order_id,:user_id,:item_id

  # ここにバリデーションの処理を書く
  validates :post_code, presence: true
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :municipalities, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :order_id, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true

  

  def save
    # 各テーブルにデータを保存する処理を書く
    order =Order.create(:user_id user_id,:item_id item_id)

    Address.create(:post_code post_code,:prefecture_id prefecture_id,:municipalities municipalities,:address address,:building_name building_name,:telephone_number telephone_number,:order_id order.id)
  end
end