require 'chronic'

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
   @event.creator_id = @current_user.id
    @event.creator_name = @current_user.name
# @event.creator_id = @current_user.google_id
end  

if @event.save
	redirect_to events_path, flash: {success: "#{@event.name} Added!"}
    else
    @events = Event.all
    render :index
end	
end

# ------------------------------------

  def show
    @photo = Photo.new
    @comment = Comment.new
  end

  # ------------------------------------

  def update
    @event.update event_params
    if @event.save
      redirect_to events_path, flash: {success: "#{@event.name} Updated!"}
    else
      render :edit
    end
  end

  # ------------------------------------

  def edit
  end

  # ------------------------------------

  def send_to_google

    @event = {
      'summary' => 'New Event Title',
      'description' => 'The description',
      'location' => 'Location',
      'start' => { 'dateTime' => Chronic.parse('tomorrow 4 pm') },
      'end' => { 'dateTime' => Chronic.parse('tomorrow 5pm') },
      'attendees' => [ { "email" => 'bob@example.com' },
      { "email" =>'sally@example.com' } ] }

    client = Google::APIClient.new
    client.authorization.access_token = @current_user.access_token
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                            :parameters => {'calendarId' => @current_user.email, 'sendNotifications' => true},
                            :body => JSON.dump(@event),
                            :headers => {'Content-Type' => 'application/json'})

    redirect_to events_path
    
  end

 # ------------------------------------
 
 def destroy
    @event.destroy
    redirect_to events_path, flash: {success: "#{@event.name} was successfully Deleted!"}
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
