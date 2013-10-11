class DepartmentsController < ApplicationController
  skip_before_filter :authorize_admin
  
  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @departments }
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @department }
    end
  end

end  