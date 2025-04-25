require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nameが空だと登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank", "Name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'name_kanaが空だと登録できない' do
        @user.name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana can't be blank", "Name kana は全角カタカナで入力してください")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank", "Email には@を含めて正しく入力してください")
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'invalidemail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid", "Email には@を含めて正しく入力してください")
      end

      it '重複したemailは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password", "Password には英字と数字の両方を含めて設定してください")
      end

      it 'passwordが英字のみだと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'passwordが数字のみだと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context 'roleの設定' do
      it 'ユーザーが1人目ならroleにteacherを設定できる' do
        user = FactoryBot.build(:user, role: 'teacher')
        user.save
        expect(user.role).to eq('teacher')
      end

      it '2人目以降のユーザーはteacherを指定してもstudentになる' do
        FactoryBot.create(:user, role: 'teacher') # 1人目
        another_user = FactoryBot.build(:user, role: 'teacher')
        another_user.save
        expect(another_user.role).to eq('student')
      end
    end
  end

end
