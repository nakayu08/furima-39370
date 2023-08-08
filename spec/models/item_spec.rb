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
    context '新規出品できない場合' do
      it "nameが空では出品できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end

      it "explanationが空では出品できない" do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "説明を入力してください"
      end

      it "category_idが空では出品できない" do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の種類を入力してください"
      end

      it "カテゴリーに「---」が選択されている場合は出品できない" do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の種類を入力してください"
      end

      it "condition_idが空では出品できない" do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を入力してください"
      end

      it "商品の状態に「---」が選択されている場合は出品できない" do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を入力してください"
      end

      it "delivery_charge_idが空では出品できない" do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を入力してください"
      end

      it "配送料の負担に「---」が選択されている場合は出品できない" do
        @item.delivery_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を入力してください"
      end

      it "prefecture_idが空では出品できない" do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を入力してください"
      end

      it "発送元の地域に「---」が選択されている場合は出品できない" do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を入力してください"
      end

      it "shipment_idが空では出品できない" do
        @item.shipment_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を入力してください"
      end

      it "発送までの日数に「---」が選択されている場合は出品できない" do
        @item.shipment_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を入力してください"
      end

      it "priceが空では出品できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "値段を入力してください"

      end

      it 'priceが全角数字では出品できない' do
        @item.price = '７８９'
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は数値で入力してください"
      end

      it 'priceが300円以下では出品できない' do
        @item.price = Faker::Number.between(from: 1, to: 300)
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は300以上の値にしてください"
      end

      it 'priceが9,999,999円以上では出品できない' do
        @item.price = Faker::Number.between(from: 9999999)
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は整数で入力してください"
      end

      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end

      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

    end
  end
  
end
