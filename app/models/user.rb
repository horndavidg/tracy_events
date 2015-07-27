require 'net/http'
require 'json'

class User < ActiveRecord::Base
	validates :email, :name, :google_id, :expires_at, :refresh_token, :access_token, presence: true
	has_many :event_users, dependent: :destroy
	has_many :events, through: :event_users

	  def to_params
	    {'refresh_token' => refresh_token,
	    'client_id' => ENV['CLIENT_ID'],
	    'client_secret' => ENV['CLIENT_SECRET'],
	    'grant_type' => 'refresh_token'}
	  end
	 
	  def request_token_from_google
	    url = URI("https://accounts.google.com/o/oauth2/token")
	    Net::HTTP.post_form(url, self.to_params)
	  end
	 
	  def refresh!
	    response = request_token_from_google
	    data = JSON.parse(response.body)
	    update_attributes(
	    access_token: data['access_token'],
	    expires_at: Time.now + (data['expires_in'].to_i).seconds)
	  end
	 
	  def expired?
	    expires_at < Time.now
	  end
	 
	  def fresh_token
	    refresh! if expired?
	    access_token
	  end
	 

end
