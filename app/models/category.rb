class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  
  has_many :menus
  scope :menu_list,order("name")
  validates_presence_of  :name
  validates_uniqueness_of :name
  
end
