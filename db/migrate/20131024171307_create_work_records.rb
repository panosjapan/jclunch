class CreateWorkRecords < ActiveRecord::Migration
  def change
    create_table :work_records do |t|

      t.string :state
      t.date  :work_on
      t.time :attend_at
      t.time :start_at
      t.time :end_at
      t.time :lunch_start_at
      t.time :lunch_end_at
      t.time :left_at
      t.decimal :wage,    :default => 0.0, :precision => 8, :scale => 2
      t.integer :user_id
      t.integer :department_id
      t.integer :approved_by

      t.timestamps
    end
  end
end
