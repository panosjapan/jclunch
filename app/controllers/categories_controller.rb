class CategoriesController < ApplicationController
  skip_before_filter :authorize_admin, :authorize
  
  def show
    @menus = Menu.where('category_id' => (params[:id]))
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end
    
end
