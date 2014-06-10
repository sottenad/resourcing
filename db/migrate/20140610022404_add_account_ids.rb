class AddAccountIds < ActiveRecord::Migration
  def up
  	add_column :allocations, :account_id, :integer
  	add_column :projects, :account_id, :integer
  	add_column :user_groups, :account_id, :integer
  
  end
  
  def down
    
    remove_column :allocations, :account_id, :integer
  	remove_column :projects, :account_id, :integer
  	remove_column :user_groups, :account_id, :integer

  end
end
