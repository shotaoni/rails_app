# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { User.new(name: 'shotaonizuka', email: 'syota.oni@gmail.com',
  password: 'hogehoge', password_confirmation: 'hogehoge') }

  describe 'user name email validation' do
    
    it '値が有効であること' do
      expect(user).to be_valid
    end

    it 'nameが有効でないこと' do
      user = User.new(name: '', email: 'syota.oni@gmail.com')
      expect(user).to be_invalid
    end

    it 'emailが有効でないこと' do
      user = User.new(name: 'shotaonizuka', email: '')
      expect(user).to be_invalid
    end

    it 'nameが有効でないこと' do
      user = User.new(name: 'a' * 51, email: 'syota.oni@gmail.com')
      expect(user).to be_invalid
    end

    it 'emailが有効でないこと' do
      user = User.new(name: 'shotaonizuka', email: 'a' * 254 + '@sample.com')
      expect(user).to be_invalid
    end

    it 'emailが有効であること' do
      user.email = 'user@example.com'
      expect(user).to be_valid
    end

    it 'emailが有効であること' do
      user.email = 'USER@foo.COM'
      expect(user).to be_valid
    end

    it 'emailが有効でないこと' do
      user.email = 'user@example,com'
      expect(user).to be_invalid
    end

    it 'emailが有効でないこと' do
      user.email = 'user_at_foo.org'
      expect(user).to be_invalid
    end

    it 'emailが有効でないこと' do
      user.email = 'user.name@example.'
      expect(user).to be_invalid
    end

    it 'emailが有効でないこと' do
      user.email = 'foo@bar_baz.com'
      expect(user).to be_invalid
    end

    it 'emailが一意性になっていること' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end

    it 'emailを小文字に変換できていること' do
      user.email = 'Foo@ExAMPle.CoM'
      user.save!
      expect(user.reload.email).to eq 'foo@example.com'
    end
  end 

  describe 'user password validation' do
    context 'パスワードが有効な値の場合' do
      it '有効であること' do
        user.password = user.password_confirmation = 'a' * 6
        expect(user).to be_valid
      end
    end

    context 'パスワードが空白の場合' do
      it '有効でないこと' do
        user.password = user.password_confirmation = ' ' * 6
        expect(user).to be_invalid
      end
    end

    context 'パスワードが5文字の場合' do
      it '有効でないこと' do
        user.password = user.password_confirmation = 'a' * 5
        expect(user).to be_invalid
      end
    end
  end
end

