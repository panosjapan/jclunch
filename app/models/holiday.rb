class Holiday < ActiveRecord::Base
  attr_accessible :holiday, :user_id
  validate :not_past_month
  validate :exist_order  
  
  belongs_to :user
	
  def exist_order
    @holidays = Holiday.where('user_id' => self.user_id).where('holiday' => self.holiday)
   
    if @holidays.size > 0
      errors.add(:holiday, "You have already taken holidays for that month")
    end
  end
  
  def not_past_month
    if self.holiday < Date.today.beginning_of_month
      errors.add(:holiday, 'You can choose only a future month')
    end
  end
  
  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = Holiday.find_or_create_by_name(name) if name.present?
  end
  
end
