class EventsController < ApplicationController
  

  def index
  	@events = Event.all
  	@event = Event.new
  end

def create

@event = Event.new event_params
# unless current_user == nil
# @event.creator_id = session[:user_id]
# end 
@event.creator_id = 1 

if @event.save
	redirect_to events_path, flash: {success: "event added!"}
    else
    render :index
end	
end



  def show
  end

  def edit
  end



















private  

def event_params
    params.require(:event).permit(
      :date,
      :description,
      :duration,
      :address, 
      :time,
      :lat,
      :long,
      :name
    )
end












end
