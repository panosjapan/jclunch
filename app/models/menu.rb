class Menu < ActiveRecord::Base
   
  attr_accessible :name, :photo, :price, :category, :category_id, :category_name
  translates :name
  class Translation
      attr_accessible :locale
    end
  belongs_to :category
  validates_length_of :name, :within => 3..40
  validates_uniqueness_of :name
	validates_presence_of :name, :price, :category  
  
  scope :active,  where(state: 'active')
  scope :hidden,  where(state: 'hidden')
  
  has_attached_file :photo, :styles => { :small => "150x150>", :medium => "250x250" },
                    :url  => "/assets/menus/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/menus/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by_name(name) if name.present?
  end
  
  def to_param
     "#{id}-#{name.gsub(/\s/,'-')}".parameterize
   end
   
   state_machine :initial => :active do
     event :activate do
       transition :hidden => :active
     end

     event :hide do
       transition :active => :hidden
     end
   end

end