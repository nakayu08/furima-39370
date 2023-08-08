class OrderFrom
  include ActiveModel::Model
  attr_accessor :post_code,:prefecture_id,:municipalities,:address,:building_name,:telephone_number,:order_id,:user_id,:item_id

  attr_accessor :token
  validates :token, presence: true

  # ここにバリデーションの処理を書く
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" } 

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/ }
    validates :municipalities, presence: true
    validates :address, presence: true
    validates :telephone_number,format: {with:/\A\d{10}\z|\A\d{11}\z/ }
  end

  

  def save
    # 各テーブルにデータを保存する処理を書く
    order = Order.create(user_id: user_id,item_id: item_id)
    Address.create(post_code: post_code,prefecture_id: prefecture_id,municipalities: municipalities,address: address,building_name: building_name,telephone_number: telephone_number,order_id: order.id)
  end
end