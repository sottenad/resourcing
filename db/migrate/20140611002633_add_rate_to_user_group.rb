class AddRateToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :rate, :integer
  end
end
