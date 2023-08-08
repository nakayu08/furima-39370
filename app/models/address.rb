class Address < ApplicationRecord
  belongs_to :order

  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" } 

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
