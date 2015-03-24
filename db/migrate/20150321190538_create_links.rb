class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.text :link_url
      t.integer :year
      t.text :about_link
      t.integer :user_id
      t.timestamps
    end
  end
end
