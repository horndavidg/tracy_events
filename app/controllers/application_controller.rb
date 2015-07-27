class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user





















 def current_user
  # Let's not make a database query if we don't need to!
   return unless session[:user_id]
  # Defines @current_user if it is not already defined.
   @current_user ||= User.find_by_id(session[:user_id])
 end
  helper_method :current_user #make it available in views (it will be available in all controllers as well


end