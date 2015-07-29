require 'chronic'
class UsersController < ApplicationController
  
  
  before_action :find_user, only: [:update]  


# -----------------------------------------

  def show
  	@user = User.find params[:id]

  	@created_current_events = Event.order(start_date: :asc).where(creator_id: @user.id).where("start_date >= ?", Time.now)
  	@created_past_events = Event.order(start_date: :asc).where(creator_id: @user.id).where('start_date < ?', Time.now)
    @created_events = Event.where(creator_id: @user.id)

    #need @attending_events and @attended_events
  end

# -----------------------------------------






# -----------------------------------------

 private

  def find_user

  	@user = User.find @current_user.id
  	
  end








end
