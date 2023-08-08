require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end


  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、名字と名前、全角（漢字・ひらがな・カタカナ）、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスを入力してください"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'test123456'
        @user.password_confirmation = 'test1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'test0'
        @user.password_confirmation = 'test0'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが英語だけでは登録できない' do
        @user.password = 'abcdefg'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'あABECD'
        @user.password_confirmation = 'あABECD'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字(カナ)を入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
        @user.first_name = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は不正な値です")

      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
        @user.last_name = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it 'first_name_kanaが全角（カタカナ）での入力でないと登録できない' do
        @user.first_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字(カナ)は不正な値です")
      end
      it 'last_name_kanaが全角（カタカナ）での入力でないと登録できない' do
        @user.last_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)は不正な値です")
      end


      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end