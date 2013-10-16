class Search < ActiveRecord::Base
  attr_accessible :max_date, :min_date, :region_id
  
  def orders
    @orders ||= find_orders
  end

  private

  def find_orders
    orders = Order.order(:date)
    
    products = orders.where(region_id: region_id) if region_id.present?
    orders = orders.where("date >= ?", min_date) if min_date.present?
    orders = orders.where("date <= ?", max_date) if max_date.present?
    orders
  end
end
