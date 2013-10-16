class AddStateToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :state, :string
  end
end
