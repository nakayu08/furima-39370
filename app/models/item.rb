class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :order

  validates :name, presence: true
  validates :explanation, presence: true
  validates :image, presence: true
  validates :price, presence: true,numericality: { only_integer: true , greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999}

  validates :category_id, numericality: { other_than: 1, message: "を入力してください" } 
  validates :condition_id, numericality: { other_than: 1, message: "を入力してください" } 
  validates :delivery_charge_id, numericality: { other_than: 1, message: "を入力してください" } 
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" } 
  validates :shipment_id, numericality: { other_than: 1, message: "を入力してください" } 
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipment

end
