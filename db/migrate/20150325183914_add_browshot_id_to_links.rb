class AddBrowshotIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :browshot_id, :integer
  end
end
