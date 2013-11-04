class RemoveColumns < ActiveRecord::Migration
  def up
    remove_column :orders, :menu_id
    remove_column :orders, :second_menu_id
  end

  def down
  end
end
