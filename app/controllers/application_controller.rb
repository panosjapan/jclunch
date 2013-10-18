class ApplicationController < ActionController::Base
  before_filter :authorize#, :authorize_admin

  protect_from_forgery
  
  #before_filter :authorize
  protected
  
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user


    def authorize
  	  redirect_to root_url, alert: "Not authorized" if current_user.nil? 
  	end
      
    def authorize_admin
      
  	  redirect_to admin_root_url, alert: "Not authorized" if current_user.nil? || current_user.admin == "No"
  	end
  	    
end
