class CreateSavedjobs < ActiveRecord::Migration
  def change
    create_table :savedjobs do |t|
      t.string :title
      t.string :job_id
    end
  end
end
