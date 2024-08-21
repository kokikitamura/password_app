class CreatePasswords < ActiveRecord::Migration[7.0]
  def change
    create_table :passwords do |t|
      t.string :title
      t.string :account
      t.string :password
      t.string :url
      t.text :memo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :passwords, [:user_id, :created_at, :upadted_at]
  end
end
