class AddAllocations < ActiveRecord::Migration
  def up
  	create_table :allocations do |t|
	  	t.datetime :start_date
	  	t.datetime :end_date
	  	t.decimal :hours_per_day
  	end
  	
  	add_reference :allocations, :project
  	add_reference :allocations, :user
  	
  	
  end
  
  def down
  	drop_table :allocations
  end
end
