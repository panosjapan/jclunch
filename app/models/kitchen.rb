class Kitchen < User
  def kitchen?
    true
  end
  
  def admin
    false
  end
  
  def staff
    false
  end
  
  def name
    "kitchen"
  end
end