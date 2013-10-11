class Category < ActiveRecord::Base
  attr_accessible :name
  
  scope :menu_list,order("name")
end
