class AdminController < ApplicationController
  skip_before_filter :authorize, :authorize_kitchen
  #before_filter :authorize_admin
  
  
	layout 'admin'
	@orders = Order.all
	def authorize2
    unless User.find_by_id(session[:user_id])
     redirect_to admin_root_url, alert: "Not Authorized"
      end
    end

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