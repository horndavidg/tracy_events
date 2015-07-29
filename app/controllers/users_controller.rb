class UsersController < ApplicationController
  
  
  before_action :find_user, only: [:update]  


# -----------------------------------------

  def show
  	@user = User.find params[:id]

  	@created_current_events = Event.where("creator_id = ?", @user.id).where("start_date >= ?", Date.today)
  	@created_past_events = Event.where('creator_id: ?', @user.id).where('start_date < ?', Date.today)
  	binding.pry
    @created_events = Event.where(creator_id: @user.id)
  end

# -----------------------------------------






# -----------------------------------------

 private

  def find_user

  	@user = User.find @current_user.id
  	
  end








end
