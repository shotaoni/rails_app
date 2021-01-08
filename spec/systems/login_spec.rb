require 'rails_helper'

RSpec.describe "Logins", type: :system do
    include SessionsHelper

  let(:user) { create(:user) }

  def post_valid_information(remember_me = 0)
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    }
  end

  it "does not log out twice" do
    get login_path
    post_valid_information(0)
    expect(logged_in?).to be_truthy
    follow_redirect!
    expect(request.fullpath).to eq '/users/1'
    delete logout_path
    expect(logged_in?).to be_falsey
    follow_redirect!
    expect(request.fullpath).to eq '/'
    delete logout_path
    follow_redirect!
    expect(request.fullpath).to eq '/'
  end

  it "succeeds remember_token because of check remember_me" do
    get login_path
    post_valid_information(1)
    expect(logged_in?).to be_truthy
    expect(cookies[:remember_token]).not_to be_nil
  end

  it "has no remember_token because of check remember_me" do
    get login_path
    post_valid_information(0)
    expect(logged_in?).to be_truthy
    expect(cookies[:remember_token]).to be_nil
  end

  it "has no remember_token when users logged out and logged in" do
    get login_path
    post_valid_information(1)
    expect(logged_in?).to be_truthy
    expect(cookies[:remember_token]).not_to be_empty
    delete logout_path
    expect(logged_in?).to be_falsey
    expect(cookies[:remember_token]).to be_empty
  end

  describe "Login" do
    context "invalid" do
      it "is invalid because it has no information" do
        visit login_path
        expect(page).to have_selector '.login-container'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        find(".form-submit").click
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert-danger'
      end

      it "deletes flash messages when users input invalid information then other links" do
        visit login_path
        expect(page).to have_selector '.login-container'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        find(".form-submit").click
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert-danger'
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end

    context "valid" do
      it "is valid because it has valid information" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        find(".form-submit").click
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.show-container'
      end

      it "contains logout button without login button" do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        find(".form-submit").click
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.show-container'
        expect(page).to have_selector '.btn-logout-extend'
        expect(page).not_to have_selector '.btn-login-extend'
      end
    end
  end

  describe "Logout" do 
    it "contains login button without logout button" do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      find(".form-submit").click
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.show-container'
      expect(page).to have_selector '.btn-logout-extend'
      expect(page).not_to have_selector '.btn-login-extend'
      click_on 'ログアウト'
      expect(current_path).to eq root_path
      #expect(page).to have_selector '.home-container'
      #expect(page).to have_selector '.btn-login-extend'
      #expect(page).not_to have_selector '.btn-logout-extend'
    end
  end
end