require 'chronic'

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
