class PhotosController < ApplicationController
  
before_action :confirm_logged_in, except: [:show, :index]
before_action :ensure_correct_user_for_photo, only: [:create, :edit]
before_action :set_photo, only: [:destroy, :edit, :update]
before_action :set_event, only: [:create]    

# ----------------------------

  def edit
  end

# ----------------------------

  # def new
  # end

# ----------------------------

  def create
  @photo = Photo.new photo_params

if @current_user
   @photo.creator_id = @current_user.id
  @photo.creator_name = @current_user.name
# @event.creator_id = @current_user.google_id
end  

@photo.event_id = params[:event_id]

if @photo.save
	redirect_to event_path(@photo.event_id), flash: {success: "Picture Added!"}
    else
    @comment = Comment.new
    render "events/show"
end	
  	
  end


# ----------------------------

def update

   @photo.update photo_params
    if @photo.save
      redirect_to edit_event_path(@photo.event_id), flash: {success: "You updated the Photo!"}
    else
      render :edit
    end
  
end


# ----------------------------


def destroy
  @photo.destroy
  redirect_to edit_event_path(@photo.event_id), alert: "Photo Removed!"
end

# ----------------------------


























# ----------------------------

private  # ----------------------------

def photo_params
    params.require(:photo).permit(
      :url,
      :description
    )
end

 def set_photo
    @photo = Photo.find params[:id]
 end

 def set_event
    @event = Event.find params[:event_id]
 end

 def set_comment
    event = Event.find params[:event_id]
    @comments = event.comments
 end


def ensure_correct_user_for_photo
    attending = []
    event = Event.find params[:event_id]
    event.users.each do |user|
        attending << user.id
    end
    unless attending.any? {|id| id == current_user.id}
      redirect_to :back, alert: "Not Authorized"
    end
end









end
