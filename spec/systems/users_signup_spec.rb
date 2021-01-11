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

  #it "is valid because it fulfils form information" do
  #  visit signup_path
  #  submit_with_valid_information
  #  expect(current_path).to eq root_path
  #  expect(page).to have_selector '.alert-info'
  #end
end
