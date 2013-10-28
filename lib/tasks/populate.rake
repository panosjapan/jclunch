namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    
 Order.populate 100 do |order|
          order.user_id = [1, 3, 7, 8] 
          order.menu_id = [1, 3, 10, 13]
          order.region_id = [1, 2, 3]
          order.date  = 3.days.ago..Time.now
        end
    
  end
end