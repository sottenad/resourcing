class AddSubscriptions < ActiveRecord::Migration
  def up
  	create_table :subscription_types do |t|
  		t.string :title
  		t.integer :price
 		t.string :stripe_plan_id
  		t.text :description
  		t.timestamps
  	end
  
  	create_table :subscriptions do |t|
  		t.integer :subscription_type_id
  		t.integer :user_id
  		t.boolean :active
	  	t.timestamps
  	end
  	
  	add_index :subscriptions, :user_id, :unique => true
  	
  end
  def down

   	drop_table :subscription_types
  	drop_table :subscriptions
  end
end
