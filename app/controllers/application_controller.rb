#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    return unless session[:user_id]
    session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  helper_method :current_user
  
  def authenticate
    current_user.is_a?(User) ? true : access_denied
  end
  
  def access_denied
    redirect_to login_path and return false
  end
end
