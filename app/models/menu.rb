class Menu < ActiveRecord::Base
   
  attr_accessible :name, :line_item, :line_item_id, :second_menu_id, :photo, :price, :category, 
  :category_id, :category_name, :category_one_lunch
  has_many :line_items
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
                    #:url  => "/assets/menus/:id/:style/:basename.:extension",
                    #:path => ":rails_root/public/assets/menus/:id/:style/:basename.:extension"
                     :storage => :s3,
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => ":attachment/:id/:style.:extension"
                      
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  def category_one_lunch
    category.try(:one_lunch)
  end

  def category_one_lunch=(one_lunch)
    self.category = Category.find_or_create_by_one_lunch(one_lunch) if one_lunch.present?
  end
  
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