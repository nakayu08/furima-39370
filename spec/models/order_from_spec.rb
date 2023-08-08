require 'rails_helper'

RSpec.describe OrderFrom, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_from= FactoryBot.build(:order_from,user_id: @user.id,item_id: @item.id)
    sleep 0.1 
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば購入できること' do
      expect(@order_from).to be_valid
    end
    it '建物名が空でも購入できること' do
      @order_from.building_name=''
      expect(@order_from).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号は空では保存できないこと' do
      @order_from.post_code=''
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "郵便番号を入力してください"
    end
    it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
      @order_from.post_code='1234-555'
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "郵便番号は不正な値です"
      
    end
    it '都道府県に「---」が選択されている場合は購入できないこと' do
      @order_from.prefecture_id='1'
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "都道府県を入力してください"
    end

    it "prefecture_idが空では出品できない" do
      @order_from.prefecture_id=''
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "都道府県を入力してください"
    end
    
    it '市区町村が空だと購入できないこと' do
      @order_from.municipalities=''
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "市区町村を入力してください"
    end
    it '番地が空だと購入できないこと' do
      @order_from.address=''
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "番地を入力してください"
      
    end
    it '電話番号が空だと購入できないこと' do
      @order_from.telephone_number=''
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "電話番号を入力してください"
      
    end
    it '電話番号が9桁以下だと購入できないこと' do
      @order_from.telephone_number='123456789'
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "電話番号は不正な値です"
      
    end
    it '電話番号が12桁以上だと購入できない' do
      @order_from.telephone_number='123456789012'
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "電話番号は不正な値です"
      
    end
    it '電話番号が半角数値でないと購入できないこと' do
      @order_from.telephone_number='０9098765432'
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "電話番号は不正な値です"
      
    end
    it 'user_idが紐づいていなければ購入できないこと' do
      @order_from.user_id=nil
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "Userを入力してください"
      
    end
    it 'item_idが紐づいていなければ購入できないこと' do
      @order_from.item_id=nil
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "Itemを入力してください"
      
    end

    it "tokenが空では登録できないこと" do
      @order_from.token=nil
      @order_from.valid?
      expect(@order_from.errors.full_messages).to include "クレジットカード情報を入力してください"
    end

  end
end
