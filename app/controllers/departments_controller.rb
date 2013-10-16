class DepartmentsController < ApplicationController
  skip_before_filter :authorize_admin
  
  # GET /departments
  # GET /departments.json
  
  # GET /departments/1
  # GET /departments/1.json
  
end  