class KitchenController < ApplicationController
  skip_before_filter :authorize, :authorize_admin
  #before_filter :authorize_kitchen
  
	layout 'kitchen'
	@orders = Order.all
	

end