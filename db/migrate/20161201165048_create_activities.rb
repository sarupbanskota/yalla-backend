class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :request, foreign_key: true
      t.string :action
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
