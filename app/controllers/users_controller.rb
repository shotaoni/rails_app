# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[show edit update index]
  before_action :correct_user, only: %i[show edit update]

  def index
    #@users = User.all
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '登録が完了しました'
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールの更新に成功しました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールの編集に失敗しました'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
