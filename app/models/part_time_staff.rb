class PartTimeStaff < User
  def part_time_staff?
    true
  end
  
  def admin?
    false
  end
  
  def kitchen?
    false
  end  
end