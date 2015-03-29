class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.string :title
      t.string :username
      t.integer :link_id
      t.integer :user_id
    end
  end
end
