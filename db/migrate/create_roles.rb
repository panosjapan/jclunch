class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
    	t.string :name

      t.timestamps
    end
    Role.create(name: "admin")
  end
end
