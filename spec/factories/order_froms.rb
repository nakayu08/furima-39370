FactoryBot.define do
  factory :order_from do
    post_code { '123-1234'}
    prefecture_id { 3 }
    municipalities { '横浜市緑区' }
    address { '3-4' }
    building_name { '青山ビル' }
    telephone_number { '09012341234' }


    association :user_id, factory: :user
    association :item_id, factory: :item
  end
end
