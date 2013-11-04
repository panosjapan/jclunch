class LineItem < ActiveRecord::Base
  attr_accessible :menu, :menu_id, :menu_name, :menu_price, :order, :order_id
  
  belongs_to :order
  belongs_to :menu
  
  def menu_name
    menu.try(:name)
  end

  def menu_name=(name)
    self.menu = Menu.find_or_create_by_name(name) if name.present?
  end
  
  def menu_price
     menu.try(:price)
   end

   def menu_name=(price)
     self.menu = Menu.find_or_create_by_price(price) if price.present?
   end
   
end
