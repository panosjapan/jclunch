class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :user_id
      t.date :holiday

      t.timestamps
    end
  end
end
