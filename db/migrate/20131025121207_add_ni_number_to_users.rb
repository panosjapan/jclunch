class AddNiNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ni_number, :string
  end
end
