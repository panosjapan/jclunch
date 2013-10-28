class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :set_locale
  
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
  	  redirect_to admin_login_url, alert: "Not authorized" if !current_user || current_user.kind != "Admin"
  	end
  	
  	def authorize_kitchen
  	  redirect_to kitchen_login_url, alert: "Not authorized" if !current_user || current_user.kind != "Kitchen"
  	end
  	
    private

    def set_locale
      I18n.locale = params[:locale] if params[:locale].present?
      # current_user.locale
      # request.subdomain
      # request.env["HTTP_ACCEPT_LANGUAGE"]
      # request.remote_ip
    end

    def default_url_options(options = {})
      {locale: I18n.locale}
    end
  	    
end
