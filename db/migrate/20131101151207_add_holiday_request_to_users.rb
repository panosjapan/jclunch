class AddHolidayRequestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :holiday_request, :boolean,  :default => false
  end
end
