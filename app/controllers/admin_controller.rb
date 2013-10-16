class AdminController < ApplicationController

	layout 'admin'
	@orders = Order.all
	def authorize2
    unless User.find_by_id(session[:user_id])
     redirect_to admin_root_url, alert: "Not Authorized"
      end
    end

end