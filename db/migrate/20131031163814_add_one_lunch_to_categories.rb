class AddOneLunchToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :one_lunch, :string
  end
end
