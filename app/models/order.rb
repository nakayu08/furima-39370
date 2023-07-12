class Order < ApplicationRecord
  belongs_to :item  # itemsテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション
end
