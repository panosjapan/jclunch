class Staff < User
  def staff?
    true
  end
  
  def admin?
    false
  end
  
  def kitchen?
    false
  end
  
  def name
    "staff"
  end
end