class AddStripeidToUser < ActiveRecord::Migration
  def up
    add_column :users, :stripe_customer_id, :string
  end
  def down
    remove_column :users, :stripe_customer_id, :string
  end
end
