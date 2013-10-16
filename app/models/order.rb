class Order < ActiveRecord::Base
  attr_accessible :menu, :menu_id, :menu_name, :region, :region_id, :region_name, :date, :user, :user_id, :user_name
  validate :not_past_date, :time
  
 validates_uniqueness_of :user_id, :scope => :date, :message => "You have already ordered for that date"

  
  belongs_to :region
	belongs_to :menu
	belongs_to :user
	
	validates_presence_of  :menu_id, :region_id

  def not_past_date
    if self.date <= Date.today 
      errors.add(:date, 'You can choose only a future date')
    end
  end
	
	
	def time
	 
	    d = Time.now+14.hour
	    if self.date <= d.to_date
      errors.add(:date, 'Next day lunch can be ordered before 10am')
    end
  end
  
  def region_name
    region.try(:name)
  end

  def region_name=(name)
    self.region = Region.find_or_create_by_name(name) if name.present?
  end
  
  def exist_order
    user = User.find_by_user_id(params[:user_id])
    date = User.find_by_date(params[:date])
    if user && date
      return false
    else

      return true
  end
  end  
  
  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = Region.find_or_create_by_name(name) if name.present?
  end
   
  def menu_name
    menu.try(:name)
  end

  def menu_name=(name)
    self.menu = Category.find_or_create_by_name(name) if name.present?
  end
  
end
