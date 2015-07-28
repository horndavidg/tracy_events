class SessionsController < ApplicationController
  def new
  end

  def create
  	@auth = request.env['omniauth.auth']
  	# if !@auth['credentials']['refresh_token']
  	# 	redirect_to root_path, flash: {alert: "Sorry, but please go to https://myaccount.google.com/u/0/security, remove us from 'Apps connected to your account' and try again."}
  	# else
  	
	  	@user = User.find_or_create_by(google_id: @auth['uid']) do |c|
	  		c.google_id = @auth['uid']
	  		c.name = @auth['info']['first_name']
	  		c.email = @auth['info']['email']
	  		c.access_token = @auth['credentials']['token']
	  		c.refresh_token = @auth['credentials']['refresh_token']
	  		c.expires_at = @auth['credentials']['expires_at']
	  		 # binding.pry
		end
		# binding.pry
		@user.fresh_token
		session[:user_id] = @user.google_id
		# binding.pry
	  	redirect_to events_path
	# end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to root_path

  end


end
