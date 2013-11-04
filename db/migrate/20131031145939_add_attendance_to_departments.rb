class AddAttendanceToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :attendance, :string
  end
end
