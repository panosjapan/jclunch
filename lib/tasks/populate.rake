namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    
 Order.populate 100 do |order|
          order.user_id = [1, 3]
          order.menu_id = [1, 2, 3]
          order.region_id = [1, 2]
          order.date  = 2.years.ago..Time.now
        end
    
  end
end
