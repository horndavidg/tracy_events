require 'chronic'
require 'googleauth'
require 'google/apis/calendar_v3'

class EventsController < ApplicationController

  before_action :confirm_logged_in, only: [:edit, :attend]
  before_action :ensure_correct_user_for_event, only: [:edit, :not_attending]
  before_action :set_event, only: [:show, :attend, :destroy, :edit, :update, :not_attending]
  before_action :find_user, only: [:attend, :create, :not_attending]
  
# ------------------------------------


  def index
  	# @events = Event.all
    @events = Event.order(start_date: :asc).where("start_date >= ?", Time.now)
  	@event = Event.new

    respond_to do |format|
      format.html do
        render :index
      end
        format.json { render :json => @events }
    end

  end

# ------------------------------------
# ------------------------------------

def create

  # binding.pry
  if params[:event][:address] == ""

  redirect_to events_path, flash: {alert: "Please enter a valid address!"}


  elsif params[:event][:address] != ""

    query = URI.encode(params[:event][:address])
    loc = Typhoeus.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{query}&bounds=37.660450,-121.507759|37.773429,-121.329231")
    result = JSON.parse loc.response_body

      if result["results"] == []
       #send back json that will append to the page
        redirect_to events_path, flash: {alert: "Please enter a valid address!"}
      
      else

        lat = result["results"][0]["geometry"]["location"]["lat"]
        long = result["results"][0]["geometry"]["location"]["lng"]
        
        @event = Event.new event_params
        @event.lat = lat
        @event.long = long
        @event.creator_id = @current_user.id
        @event.creator_name = @current_user.name


        if @event.save
          @user.events << @event
          respond_to do |format|

            format.html do
              redirect_to events_path, flash: {success: "#{@event.name} Added!"}
            end

            format.json { render :json => @event }
          end
          
        else
          @events = Event.all
          @user = User.find @current_user.id
          flash.now[:alert] = "Please make sure you have entered a valid address!"
          render :index
        end 


      end
    
  end

    
end

# ------------------------------------

# -----------------------------------



  def show
    @photo = Photo.new
    @comment = Comment.new
    @attending = []
    @event.users.each do |user|
        @attending << user.id
    end
    @comments = @event.comments.order(created_at: :desc)
    @start_time = extract_date(@event.start_date) + " at " + convert_from_military(@event.start_time) + morning_or_night(@event.start_time)
    @end_time = extract_date(@event.end_date) + " at " + convert_from_military(@event.end_time) + morning_or_night(@event.end_time)
   
    respond_to do |format|
      format.html do
        render :show
      end
        format.json { render :json => @event }
    end
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

    attending = []
    
    @event.users.each do |user|
        attending << user.id
    end

    if attending.any? {|id| id == current_user.id}
        redirect_to :back, alert: "You are already attending this event"
           
        else
        @user.events << @event

        redirect_to event_path(@event.id), flash: {success: "#{@user.name} is Attending!"}
    end
  end

  # ------------------------------------

  def edit
    @comments = @event.comments.order(created_at: :desc)
  end

  # ------------------------------------

  def send_to_google

    @event = Event.find_by_id(params[:event_id])
    @current_user.fresh_token

    if @event 


          a = @event.start_date.to_s[0..9]
          b = @event.start_time.to_s[10..18]
         
          @date_start_format = a + b

          c = @event.end_date.to_s[0..9]
          d = @event.end_time.to_s[10..18]

          @date_end_format = c + d



      calendar = Google::Apis::CalendarV3::CalendarService.new

      calendar.authorization = Signet::OAuth2::Client.new({
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        access_token: @current_user.access_token
      })
      @summary = @event.name
      @location = @event.address
      @start_time = Chronic.parse(@date_start_format)
      @end_time = Chronic.parse(@date_end_format)

      


      event = Google::Apis::CalendarV3::Event.new(
                                      summary: @summary,
                                      location: @location,
                                      start: Google::Apis::CalendarV3::EventDateTime.new({date_time: DateTime.parse(@start_time.to_s), time_zone: "America/Los_Angeles"}),
                                      end: Google::Apis::CalendarV3::EventDateTime.new({date_time: DateTime.parse(@end_time.to_s), time_zone: "America/Los_Angeles"})
                                      )

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

 # ------------------------------------


private  # ----------------------------------

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



  def find_user

      @user = User.find @current_user.id
      
  end


  def ensure_correct_user_for_event
      event = Event.find params[:id]
      unless event.creator_id.to_i == current_user.id
        redirect_to :back, alert: "Not Authorized"
      end
  end


# Time formatting functions
  def format_time(time)
    t = (time <= 1200)?time : time - 1200
    return (t.to_s.size == 3)?t.to_s.insert(1,":") : t.to_s.insert(2,":") 
  end

  def convert_from_military(time)
    split = time.to_s.split(" ")[1]
    split.slice!(":00")
    split = split.delete(":").to_i
    split = format_time(split)

  end

  def morning_or_night(time)
    time = time.to_s.split(" ")[1]
    time.slice!(":00")
    time = time.delete(":").to_i
    if time < 12
      " AM"
    else
      " PM"
    end
  end
   
  def extract_date(date)
    date = date.httpdate
    date = date[0..-14]
  end









end

# ------------------------------------

