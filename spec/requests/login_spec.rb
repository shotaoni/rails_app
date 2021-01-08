require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do

  let(:user) { create(:user) }

  describe "GET /login" do
    context "invalid information" do
      it "fails having a danger flash message" do
        get login_path
        post login_path, params: {
          session: {
            email: "",
            password: ""
          }
        }
        expect(flash[:danger]).to be_truthy
        expect(logged_in?).to be_falsey
      end
    end

    context "valid information" do
      it "succeeds having no danger flash message" do
        get login_path
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }
        expect(flash[:danger]).to be_falsey
        expect(logged_in?).to be_truthy
      end
  
      it "succeeds login and logout" do
        get login_path
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }
        expect(logged_in?).to be_truthy
        delete logout_path
        expect(logged_in?).to be_falsey
      end
    end
  end
end