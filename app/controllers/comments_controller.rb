class CommentsController < ApplicationController
  
before_action :set_event, only: [:create]
before_action :set_comment, only: [:destroy, :edit, :update]

# -----------------------------

  def edit
  end

# ------------------------------

  def new
  end

# ------------------------------

def create

  @comment = Comment.new comment_params

if @current_user
   @comment.creator_id = @current_user.id
  @comment.creator_name = @current_user.name
# @comment.creator_id = @current_user.google_id
end  

@comment.event_id = params[:event_id]

if @comment.save
	redirect_to event_path(@comment.event_id), flash: {success: "Comment Added!"}
    else
    @photo = Photo.new
    render "events/show"
end	
  
end


# ----------------------------

def update

   @comment.update comment_params
    if @comment.save
      redirect_to edit_event_path(@comment.event_id), flash: {success: "You updated the Comment!"}
    else
      render :edit
    end
  
end


# ----------------------------


def destroy
  @comment.destroy
  redirect_to edit_event_path(@comment.event_id), alert: "Comment Removed!"
end

# ----------------------------















private  

def comment_params
    params.require(:comment).permit(
      :content
    )
end

def set_comment
    @comment = Comment.find params[:id]
end

def set_event
    @event = Event.find params[:event_id]
end




end
