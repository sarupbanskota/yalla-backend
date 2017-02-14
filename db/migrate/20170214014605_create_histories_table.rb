class CreateHistoriesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :histories_table do |t|
      t.integer :user_id
      t.integer :contract_cycle
      t.integer :category_id
      t.integer :used
      t.integer :pending
    end
  end
end
