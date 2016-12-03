class AddUsernameToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :username, :string
  end
end
