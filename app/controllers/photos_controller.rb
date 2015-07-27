class PhotosController < ApplicationController
  
  def edit
  end

  def new
  end

  def create
@photo = Photo.new photo_params

if @current_user
   @photo.creator_id = @current_user.name
# @event.creator_id = @current_user.google_id
end  

if @photo.save
	redirect_to event_path(@event), flash: {success: "picture added!"}
    else
    render :show
end	
  	
  end

































private  

def photo_params
    params.require(:photo).permit(
      :url,
      :description
    )
end

 # def set_event
 #    @event = Event.find params[:id]
 # end











end
