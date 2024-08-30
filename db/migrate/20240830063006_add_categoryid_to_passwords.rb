class AddCategoryidToPasswords < ActiveRecord::Migration[7.0]
  def change
    add_column :passwords, :category_id, :integer
  end
end
