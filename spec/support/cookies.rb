# frozen_string_literal: true

# RSpecでcookies.signedがエラーになる対処
# 環境によって参照元が変わるため定義
module Rack
  module Test
    class CookieJar
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
  end
end
