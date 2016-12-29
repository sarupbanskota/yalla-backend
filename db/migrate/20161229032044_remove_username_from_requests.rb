class RemoveUsernameFromRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :requests, :username, :string
  end
end
