class Department < ActiveRecord::Base
  attr_accessible :name, :work_start_at, :minute_step 
  
  has_many :users
  
  validates_uniqueness_of :name
	validates_presence_of :name
	
	def to_param
    "#{id}-#{name.gsub(/\s/,'-')}".parameterize
  end
  
  def work_start_at_to_strf
    self.work_start_at.to_time.strftime("%H:%M") if self.work_start_at.present?
  end
  
end
