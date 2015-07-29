class UsersController < ApplicationController
  
  
  before_action :find_user, only: [:update,:destroy]
  before_action :set_event, only: [:destroy] 


# -----------------------------------------

  def show
  	@user = User.find params[:id]

  	@created_current_events = Event.where("creator_id = ?", @user.id).where("start_date >= ?", Date.today)
  	@created_past_events = Event.where('creator_id: ?', @user.id).where('start_date < ?', Date.today)
    @created_events = Event.where(creator_id: @user.id)
  end

# -----------------------------------------

def destroy

@user.events.delete(@event)

redirect_to user_path(current_user.id)

end

# -----------------------------------------

 private

  def find_user

  	@user = User.find @current_user.id
  	
  end


def set_event
    @event = Event.find params[:id]
end






end
