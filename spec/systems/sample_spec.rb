require 'rails_helper'

feature "サンプルテスト", type: :system do
    scenario "トップページにアクセスできること" do
      visit root_path
      expect(current_path).to eq root_path
    end

    it "contains login link" do
        visit root_path
        expect(page).to have_link 'ログイン', href: login_path
    end
  end