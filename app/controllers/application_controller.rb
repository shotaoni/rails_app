# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def redirect_to_profile_if_logged_in
    redirect_to current_user if logged_in?
  end
end
