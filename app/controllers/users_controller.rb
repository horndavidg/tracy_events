class UsersController < ApplicationController
  
  
  before_action :find_user, only: [:update]  


# -----------------------------------------

  def show
  	@user = User.find params[:id]
    @created_events = Event.where(creator_id: @user.id)
  end

# -----------------------------------------

  def destory

  end










# -----------------------------------------

 private

  def find_user

  	@user = User.find @current_user.id
  	
  end








end
