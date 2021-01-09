# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersSignups', type: :system do
  it 'is invalid because it has no name' do
    visit signup_path
    fill_in '名前', with: ''
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    click_on '新規ユーザ作成'
    expect(current_path).to eq signup_path
    expect(page).to have_selector '#error_explanation'
  end

  it 'is valid because it fulfils condition of input' do
    visit signup_path
    fill_in '名前', with: 'Example User'
    fill_in 'メールアドレス', with: 'user@example.com'
    fill_in 'パスワード', with: 'password'
    click_on '新規ユーザ作成'
    expect(current_path).to eq user_path(1)
    expect(page).not_to have_selector '#error_explanation'
  end
end
