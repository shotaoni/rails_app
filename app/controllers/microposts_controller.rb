class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create edit update destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params) 
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page]).per(10)
      render 'static_pages/home'
    end
  end


  def edit
    @micropost = current_user.microposts.find_by(id: params[:id]) || nil
    if @micropost.nil?
      flash[:warning] = '編集権限がありません'
      redirect_to root_url
    end
  end

  def update
    @micropost = current_user.microposts.find_by(id: params[:id])
    @micropost.update_attributes(micropost_params)
    if @micropost.save
      flash[:success] = '編集が完了しました'
      redirect_to current_user
    else
      render 'microposts/edit'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'ログが削除されました'
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
