class PhotosController < ApplicationController
  
before_action :set_photo, only: [:destroy, :edit, :update]  


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



























private  

def photo_params
    params.require(:photo).permit(
      :url,
      :description
    )
end

 def set_photo
    @photo = Photo.find params[:id]
 end


end
