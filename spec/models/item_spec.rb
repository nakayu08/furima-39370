require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'アイテム出品' do
    context '新規出品できる場合' do
      it "name、explanation、category_id、condition_id、delivery_charge_id、prefecture_id、shipment_id、priceの値が存在すれば作成できる" do
        expect(@item).to be_valid
      end
    end
    context '新規作成できない場合' do
      it "nameが空では作成できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end

      it "explanationが空では作成できない" do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Explanation can't be blank"
      end

      it "category_idが空では作成できない" do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it "condition_idが空では作成できない" do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end

      it "delivery_charge_idが空では作成できない" do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery charge can't be blank"
      end

      it "prefecture_idが空では作成できない" do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it "shipment_idが空では作成できない" do
        @item.shipment_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipment can't be blank"
      end

      it "priceが空では作成できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"

      end

      it 'priceが全角数字では登録できない' do
        @item.price = '７８９'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end

      it 'priceが300円以下では登録できない' do
        @item.price = Faker::Number.between(from: 1, to: 300)
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end

      it 'priceが9,999,999円以上では登録できない' do
        @item.price = Faker::Number.between(from: 9999999)
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be an integer"
      end

    end
  end
  
end
