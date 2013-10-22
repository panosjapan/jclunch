class Admin < User
  def admin?
    true
  end
  
  def staff?
    false
  end
  
  def kitchen?
    false
  end
  
  def name
    "admin"
  end
end