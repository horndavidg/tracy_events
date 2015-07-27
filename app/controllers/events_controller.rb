class EventsController < ApplicationController


  before_action :set_event, only: [:show, :destroy, :edit, :update]


# ------------------------------------


  def index
  	@events = Event.all
  	@event = Event.new

  end

# ------------------------------------

def create

@event = Event.new event_params

if @current_user
   @event.creator_id = @current_user.name
# @event.creator_id = @current_user.google_id
end  

if @event.save
	redirect_to events_path, flash: {success: "event added!"}
    else
    render :index
end	
end

# ------------------------------------

  def show
    @photo = Photo.new
  end

  # ------------------------------------

  def update
    @event.update event_params
    if @event.save
      redirect_to events_path, flash: {success: "#{@event.name} updated!"}
    else
      render :edit
    end
  end

  # ------------------------------------

  def edit
  end

  # ------------------------------------

 def destroy
    @event.destroy
    redirect_to events_path, flash: {success: "#{@event.name} was successfully deleted!"}
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

 def set_event
    @event = Event.find params[:id]
 end








end
