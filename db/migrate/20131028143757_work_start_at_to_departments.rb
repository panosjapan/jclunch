class WorkStartAtToDepartments < ActiveRecord::Migration
  def change
     add_column :departments, :work_start_at, :time
   end
end
