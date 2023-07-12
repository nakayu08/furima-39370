class Address < ApplicationRecord
  belongs_to :order

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
