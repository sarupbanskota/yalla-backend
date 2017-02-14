class RemoveUnecessaryTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :categories_table
    drop_table :allocations_table
    drop_table :histories_table
  end
end
