class AddFirstNameandLastNametoAdmins < ActiveRecord::Migration
  def up
  	add_column :admins, :first_name, :string
  	add_column :admins, :last_name, :string
  	add_column :admins, :account_id, :integer
  	
  end
  def down
    remove_column :admins, :first_name, :string
  	remove_column :admins, :last_name, :string
  	remove_column :admins, :account_id, :integer

  end
end
