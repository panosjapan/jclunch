class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :menu_id
      t.integer :order_id

      t.timestamps
    end
  end
end
