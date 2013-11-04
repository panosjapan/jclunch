class AddSecondMenuIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :second_menu_id, :integer
  end
end
