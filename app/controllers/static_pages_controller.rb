# frozen_string_literal: true

class StaticPagesController < ApplicationController
  # before_action :redirect_to_profile_if_logged_in

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per(10)
    end
  end

  def about; end
end
