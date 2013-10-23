class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.decimal :price
      t.integer :category_id
      t.string :state

      t.timestamps
    end
  end
end
