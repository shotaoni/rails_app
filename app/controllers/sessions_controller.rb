class SessionsController < ApplicationController
  before_action :redirect_to_profile_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:user][:email])
    user = User.find_by(email: @user.email.downcase)
    if user && user.authenticate(params[:user][:password])
     flash[:success] = "ログインしました。"
     log_in user
     redirect_to user
    else
     flash.now[:danger] = 'メールアドレスかパスワードが正しくありません。'
     render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
