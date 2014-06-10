class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :title
      t.string :subdomain

      t.timestamps
    end
  end
end
