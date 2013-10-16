class CategoriesController < ApplicationController
  skip_before_filter :authorize_admin
  
   
end
