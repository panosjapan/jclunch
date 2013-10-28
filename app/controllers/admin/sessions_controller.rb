class Admin::SessionsController < AdminController
  #skip_before_filter :authorize, :authorize_admin
  def new
    @categories = Category.all
  end
  
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])  && user.kind == "Admin"
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token  
      else
        cookies[:auth_token] = user.auth_token
      end      
      redirect_to admin_orders_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to admin_login_url, notice: "Logged out!"
  end
end
