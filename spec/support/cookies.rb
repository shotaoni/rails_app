# RSpecでcookies.signedがエラーになる対処
# 環境によって参照元が変わるため定義
class Rack::Test::CookieJar
    def signed
      self
    end
  
    def permanent
      self
    end
  
    def encrypted
      self
    end
  end