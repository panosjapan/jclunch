class WorkRecord < ActiveRecord::Base
  attr_accessible :work_on, :start_at,:end_at,:lunch_start_at,:lunch_end_at,
                  :wage,:user_id,:approved_by, :state,:department, :department_id,
                  :attend_at,:left_at
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  #belongs_to :approved_by, :class_name => "User", :foreign_key => "user_id"
  belongs_to :department, :class_name => "Department", :foreign_key => "department_id"
  
  validates_presence_of :user_id, :work_on
  validates_uniqueness_of :work_on, scope: :user_id
  
  state_machine :initial => :not_attend do

    state :not_attend, :attended, :left, :approved, :pending
    
    event :attend do
      transition :from => [:not_attend, :pending],  :to => :attended
    end

    event :leave do
      transition :from => [:attended, :pending],  :to => :left
    end
    
    event :approve do
      transition :from => [:left, :pending],  :to => :approved
    end
    
    event :suspend do
      transition :from => [:not_attend, :attended, :left, :approved, :pending],  :to => :pending
    end
    
    before_transition :to => :attended do |wr|
      st = wr.try(:user).try(:department).try(:work_start_at)
      nt = Time.now
      wr.attend_at  = nt
      if st.present?
        wr.start_at   = (st.hour*60+st.min) < (nt.hour*60+nt.min) ? wr.start_time : st
      else
        wr.start_at   = wr.start_time
      end
    end

    before_transition :to => :left do |wr|
      wr.end_at = wr.end_time
      wr.left_at = Time.now
    end
    
  end

  scope :approved, where(:state => 'approved')
  scope :not_approved, where("work_records.state != 'approved'")
  scope :pending, where(:state => 'pending')
  scope :b_user, lambda { |uid|
    where("work_records.user_id = ?", uid) 
  }
  scope :b_dept, lambda { |did|
    where("work_records.department_id = ?", did).
    order("work_records.user_id")    
  }
  scope :monthly, lambda { |date|
    where("work_records.work_on >= '#{Time.gm(date.to_date.year,date.to_date.months_ago(1).month,21,0,0,0).to_s(:db)}' and work_records.work_on <= '#{Time.gm(date.to_date.year,date.to_date.month,20,23,59,59).to_s(:db)}'"). 
    order("work_records.work_on")
  }
  scope :daily, lambda { |date|
    where("work_records.work_on = '#{date.to_date.to_s(:db)}'")
  }

  

  def attend_at_to_strf
    begin
      self.attend_at.to_time.strftime("%H:%M")
    rescue
      ""
    end
  end
    
  def start_at_to_strf
    begin
      self.start_at.to_time.strftime("%H:%M")
    rescue
      ""
    end
  end

  def end_at_to_strf
    begin
      self.end_at.to_time.strftime("%H:%M")
    rescue
      ""
    end
  end
  
  def lunch_hours
    begin
      min = self.lunch_end_at - self.lunch_start_at
      min.divmod(60)[0].to_s + " mins"
    rescue
      "-"
    end
  end
  
  def daily_work_time
    #days = (self.end_at - self.start_at).divmod(24*60*60)
    #hours = days[1].divmod(60*60)
    #mins = hours[1].divmod(60)  
    begin
      x = ((end_h - sta_h) - (lend_h - lsta_h)).quo(60).to_f
    rescue
      x = 0
    end
    x < 0 ? 0 : x
  end
  
  def end_h
    begin
      (self.end_at.hour*60)+((self.end_at.min/15)*15)
    rescue
      0
    end
  end
    
  def sta_h
    begin
      (self.start_at.hour*60)+((ceil15(self.start_at.min)/15)*15)
    rescue
      0
    end
  end
  
  def lend_h
    begin
      (self.lunch_end_at.hour*60)+((self.lunch_end_at.min/15)*15)
    rescue
      0
    end
  end
  
  def lsta_h
    begin
      (self.lunch_start_at.hour*60)+((self.lunch_start_at.min/15)*15)
    rescue
      0
    end
  end

  def start_time
    begin
      t = Time.now
      m = ceil15(t.min)
      h = m.zero? ? t.hour+1 : t.hour
      [h,m,0].join(":")
    rescue
      t
    end    
  end

  def end_time
    begin
      t = Time.now
      [t.hour,((t.min/15)*15),0].join(":")
    rescue
      t
    end
  end

  private

  def ceil15(min)
    case min
    when 1..15
      15
    when 16..30
      30
    when 31..45
      45
    else
      0
    end
  end
end
