require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_test) { create(:user) }
  context "入力OKの場合" do
    it "バリデーションを通ること" do
      expect(user_test).to be_valid
    end
    it "メールアドレスが規定のフォーマットに従って入力されていること" do
      expect(user_test.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end
    it "パスワードが半角6文字以上8文字以内で入力されていること" do
      expect(user_test.password).to match(/\w{6,8}/)
    end
    it "確認パスワードが同一のパスワードが入力されていること" do
      expect(user_test.password_confirmation).to eq(user_test.password)
    end
  end

  context "入力NGの場合" do
    pending "メールアドレスが入力されていない場合" do
      let(:email) { nil }
      user_test.valid?
      expect(user_test.errors[:email]).to include("can't be blank")
    end
  end

  context "メソッドのテスト" do
    it "ageメソッドが正しく動作する" do
      expect(user_test.age).to be_instance_of(Integer)
    end

    pending "approvaldateメソッドが正しく動作する" do
      expect(user_test.approvaldate).to be_instance_of(Datetime)
    end
  end

end
