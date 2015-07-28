require 'chronic'
require 'googleauth'
require 'google/apis/calendar_v3'

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

  def send_to_google

    calendar = Google::Apis::CalendarV3::CalendarService.new

    calendar.authorization = Signet::OAuth2::Client.new({
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      access_token: @current_user.access_token
    })

    event = Google::Apis::CalendarV3::Event.new(summary: 'A third sample event',
                                location: '1600 Amphitheatre Parkway, Mountain View, CA 94045',

                                start: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse('2015-07-27T20:00:00')),
                                end: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse('2015-07-28T02:00:00')))
    event = calendar.insert_event('primary', event, send_notifications: true)


    redirect_to events_path
    
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
