# frozen_string_literal: true

require 'rails_helper'

#　ログインしていない時でもユーザ一覧を見ることができる、プロフィールページも見れる。メッセージ送る、投稿するときユーザログインページに飛ぶ、
#　ユーザの編集ページにアクセスした時、無効である。rootpathに飛ばされる。管理者以外はユーザを削除することができない。
#　ページネーションテストが機能しているかのテスト、管理者は適切にユーザを削除することができるか。フラッシュはでているか
RSpec.describe 'Users', type: :request do
  describe '' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end
end
