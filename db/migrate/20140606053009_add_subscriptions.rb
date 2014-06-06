class AddSubscriptions < ActiveRecord::Migration
  def up
  	create_table :subscription_types do |t|
  		t.string :subscription_name
  		t.integer :price
  		t.text :description
  	end
  
  	create_table :subscriptions do |t|
	  	t.timestamps
  	end

  	add_reference :subscriptions, :subscription_type, index:true  	
  	add_reference :users, :subscription, index:true
  end
  def down
   	remove_reference :subscriptions, :subscription_type, index:true  	
  	remove_reference :users, :subscription, index:true

   	drop_table :subscription_types
  	drop_table :subscriptions
  end
end
