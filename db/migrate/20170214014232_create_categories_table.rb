class CreateCategoriesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_table do |t|
      t.string :name
      t.string :color
    end
  end
end
