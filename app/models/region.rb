class Region < ActiveRecord::Base
  attr_accessible :name
  
  has_many :orders

  scope :menu_list,order("name")
  validates_presence_of  :name
end
