class Order < ActiveRecord::Base
  attr_accessible :menu_id, :region_id, :user_id
end
