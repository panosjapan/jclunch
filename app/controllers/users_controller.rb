class UsersController < ApplicationController
  skip_before_filter :authorize_admin
  
  
  def new
	  @user = User.new
	end
	
	def create
	  @user = User.new(params[:user])
	  if @user.save
	    cookies[:auth_token] = @user.auth_token
	    redirect_to root_url, :notice => "Signed up!"
	    redirect_to offers_path
	  else
	    render "new"
	  end
	end
	
	def request_holiday
	  User.where('id' => current_user).update_all(:holiday_request => true)
#  	current_user.update_attributes(holiday_request: true)
  	redirect_to :back
  end

  def unrequest_holiday
	  User.where('id' => current_user).update_all(:holiday_request => false)
  	redirect_to :back
  end
	
end
