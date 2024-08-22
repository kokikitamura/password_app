class RenamePasswordColumnToPasswords < ActiveRecord::Migration[7.0]
  def change
    rename_column :passwords, :password, :pass
  end
end
