class Department < ActiveRecord::Base
  attr_accessible :name 
  
  has_many :users
  
  validates_uniqueness_of :name
	validates_presence_of :name
end
