class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :one_lunch
  translates :name
  class Translation
      attr_accessible :locale
    end
  
  has_many :menus
  scope :menu_list,order("name")
  validates_presence_of  :name
  validates_uniqueness_of :name
  
end
