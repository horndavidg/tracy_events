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

  def attend
    
  end

  # ------------------------------------

  def edit
  end

  # ------------------------------------

  def send_to_google

    @event = Event.find_by_id(params[:event_id])

    if @event 
      calendar = Google::Apis::CalendarV3::CalendarService.new

      calendar.authorization = Signet::OAuth2::Client.new({
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        access_token: @current_user.access_token
      })
      @summary = @event.name
      @location = @event.address
      @start_time = Chronic.parse(@event.start_time)
      # @start_time = Chronic.parse("five hours after " + @event.start_time)
      @end_time = Chronic.parse(@event.end_time)
      # @end_time = Chronic.parse("five hours after " + @event.end_time)
      # @end_time = @event.end_time
      # binding.pry

      event = Google::Apis::CalendarV3::Event.new(summary: @summary,
                                  # location: '1600 Amphitheatre Parkway, Mountain View, CA 94045',

                                  # start: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse('2015-07-27T20:00:00')),
                                  # end: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse('2015-07-28T02:00:00')))

                                  location: @location,

                                  start: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse(@start_time.to_s)),
                                  end: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse(@end_time.to_s)))
      event = calendar.insert_event('primary', event, send_notifications: true)


      redirect_to events_path, flash: {success: "#{@summary} was added to your Google Calendar"}
    else

      redirect_to events_path, flash: {alert: "Sorry, something went wrong, please try again."}

    end


    
  end

 # ------------------------------------
 
 def destroy
    @event.destroy
    redirect_to events_path, flash: {success: "#{@event.name} was successfully Deleted!"}
 end

















private  

def event_params
    params.require(:event).permit(
      :start_date,
      :end_date,
      :description,
      :duration,
      :address, 
      :start_time,
      :end_time,
      :lat,
      :long,
      :name
    )
end

 def set_event
    @event = Event.find params[:id]
 end








end
