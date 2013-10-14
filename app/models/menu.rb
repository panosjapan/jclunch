class Menu < ActiveRecord::Base
    
  attr_accessible :name, :price, :category, :category_id, :category_name
  
  belongs_to :category
  validates_length_of :name, :within => 3..40
  validates_uniqueness_of :name
	validates_presence_of :name, :price, :category  
  
  
  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by_name(name) if name.present?
  end
  
  def to_param
     "#{id}-#{name.gsub(/\s/,'-')}".parameterize
   end

end