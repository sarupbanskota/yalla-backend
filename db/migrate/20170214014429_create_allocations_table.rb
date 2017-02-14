class CreateAllocationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :allocations_table do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :contract_cycle_allocation
    end
  end
end
