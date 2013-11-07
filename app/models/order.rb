class Order < ActiveRecord::Base
  attr_accessible :menu, :menu_id, :status, :second_menu_id, :menu_name, :menu_price, :line_item, :line_item_id, 
  :region, :region_id, :region_name, :date, :user, :user_id, :user_name, :line_items_attributes
  validate :not_past_date, :time
  validate :normal_price
  validate :one_item
  validate :accounts
  validate :no_menu
  validate :exist_order, :on => :create
  
 #validates_uniqueness_of :user_id, :scope => :date, :message => "You have already ordered for that date"

  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :line_items,  :allow_destroy => true
  belongs_to :region
	belongs_to :menu
	belongs_to :user
	
	validates_presence_of  :region_id

  def no_menu	  
   if self.line_items.size == 0 
      self.errors.add(:base, "You must choose at least one menu")
   end
  end
  
  def accounts	  
   if self.user.department_id == 10 
      self.line_items.each do |i|
        if i.menu.category_id == 5
          self.errors.add(:base, "Accounts Department Staff cannot order Sushi menus")     
        end
      end
   end
  end
  
  def one_item	  
   if self.line_items.size > 1 
     self.line_items.each do |i|
       #if i.menu.category_id == 1 || i.menu.category_id == 3 || i.menu.category_id == 4 
        if i.menu.category_one_lunch == "Yes"
         self.errors.add(:base, "You cannot combine your menu if you choose BENTO DONBURI or CURRY")
       end
     end
   end
  end
  
  def not_past_date
    if self.date <= Date.today 
      errors.add(:date, 'You can choose only a future date')
    end
  end
	
	def normal_price
   total = 0
   self.line_items.each do |i|
       total += i.menu_price
   end
   if total > 10
     self.errors.add(:base, "Total order cost exceeds 10 pounds, please place your order again")
     #flash[:alert] = 'Total order cost exceeds 10 pounds, please place your order again'
   end   
  end
	
	def time
	    d = Time.now+13.hour+30.minute
	    if self.date <= d.to_date
      errors.add(:date, 'Sorry, next day lunch can be ordered before 10:30am')
    end
  end
  
  def price
     menu.try(:price)
   end
  
  def region_name
    region.try(:name)
  end

  def region_name=(name)
    self.region = Region.find_or_create_by_name(name) if name.present?
  end
  
  def exist_order
    @orders = Order.where('user_id' => self.user_id).where('date' => self.date)
   
    if @orders.size > 0
      errors.add(:date, "You have already placed an order for this date")
    end
  end  
  
  def user_name
    user.try(:name)
  end

  def user_name=(name)
    self.user = Region.find_or_create_by_name(name) if name.present?
  end
  
  def line_item_menu_name
    line_item.try(:name)
  end

  def line_item_menu_name=(name)
    self.line_item = LineItem.find_or_create_by_name(name) if name.present?
  end
   
  def menu_name
    menu.try(:name)
  end

  def menu_name=(name)
    self.menu = Menu.find_or_create_by_name(name) if name.present?
  end
  
end
