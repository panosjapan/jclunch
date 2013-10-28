class AddMinuteStepToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :minute_step, :integer
  end
end
