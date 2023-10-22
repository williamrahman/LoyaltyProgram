class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :total_spent, default: 0
      t.integer :tier, default: 0

      t.timestamps
    end
  end
end
