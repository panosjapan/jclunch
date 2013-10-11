class AddColumnToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :category, :integer
  end
end
