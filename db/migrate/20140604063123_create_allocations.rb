class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|

      t.timestamps
    end
  end
end
