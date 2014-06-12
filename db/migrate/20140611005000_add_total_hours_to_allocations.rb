class AddTotalHoursToAllocations < ActiveRecord::Migration
  def change
    add_column :allocations, :total_hours, :decimal
  end
end
