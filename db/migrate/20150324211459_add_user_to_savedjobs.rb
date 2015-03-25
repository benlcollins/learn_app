class AddUserToSavedjobs < ActiveRecord::Migration
  def change
    add_column :savedjobs, :user_id, :integer
  end
end
