class ChangeUserNameColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :last_name, :string
    remove_column :users, :first_name, :string
    remove_column :users, :last_name_kana, :string
    remove_column :users, :first_name_kana, :string

    add_column :users, :name, :string, null: false
    add_column :users, :name_kana, :string, null: false
  end
end
