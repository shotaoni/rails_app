class StaticPagesController < ApplicationController
  before_action :redirect_to_profile_if_logged_in

  def home
  end

  def about
  end
end
