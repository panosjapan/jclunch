class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :region_id
      t.date :min_date
      t.date :max_date

      t.timestamps
    end
  end
end
