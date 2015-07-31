class SessionsController < ApplicationController
  

before_action :prevent_login_signup, only: [:new]

# ------------------------------------

  def new
  end

  # ------------------------------------

  def create
  	@auth = request.env['omniauth.auth']
  	
  	@user = User.find_or_create_by(google_id: @auth['uid']) do |c|
  		c.google_id = @auth['uid']
  		c.name = @auth['info']['first_name']
  		c.email = @auth['info']['email']
  		c.access_token = @auth['credentials']['token']
  		c.refresh_token = @auth['credentials']['refresh_token']
  		c.expires_at = @auth['credentials']['expires_at']
	end
	@user.fresh_token
	session[:user_id] = @user.google_id
  	redirect_to events_path
  end

  # ------------------------------------

  def logout
  	session[:user_id] = nil
  	redirect_to root_path

  end


end
