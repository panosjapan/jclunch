class Menu < ActiveRecord::Base
    
  attr_accessible :name, :price, :category
  
  validates_length_of :name, :within => 3..40
  validates_uniqueness_of :name
	validates_presence_of :name, :price, :category  
  

end