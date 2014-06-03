class ConfigureApp < ActiveRecord::Migration
  def up
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	
  	create_table :user_groups do |t|
  		t.string :title
  	end
  	
  	create_table :user_statuses do |t|
  		t.string :title
  	end
  	
  	create_table :projects do|t|
  		t.string :title
  		t.string :number
  		t.integer :budget_currency
  		t.integer :budget_hours
  	end
  	
  	create_table :project_statuses do |t|
  		t.string :title
  	end
  	
  	add_reference :projects, :user, index: true
  	add_reference :projects, :project_status, index: true
  	add_reference :users, :user_group, index: true
  	add_reference :users, :user_status, index: true

  	
  end
  
  def down
  	remove_column :users, :first_name, :string
  	remove_column :users, :last_name, :string
  	
  	remove_reference :users, :user_group, index: true
  	remove_reference :users, :user_status, index: true

  	drop_table :user_groups
  	drop_table :user_statuses
  	drop_table :projects
  	drop_table :project_statuses
  	
  end
end
