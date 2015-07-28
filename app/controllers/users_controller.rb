class UsersController < ApplicationController
  
  
  before_action :find_user, only: [:update]  


# -----------------------------------------

  def show
  	@user = User.find params[:id]
  end

# -----------------------------------------

def update

	# @user.events.new params[:event_id]

	

    # @add_event = @user.events.create 
    # if @add_event.save
    #   redirect_to user_path(@user), flash: {success: "Added!"}
    # else
    #   render :new
    # end
end


# -----------------------------------------



  def destory

  end



 private

  # def event_params
  #   params.require(:event).permit(
  #     :name,
  #     :id
  #   )
  # end

  def find_user

  	@user = User.find @current_user.id
  	
  end















end
