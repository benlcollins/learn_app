class CreateCommentHierarchies < ActiveRecord::Migration
  def change
    create_table :comment_hierarchies do |t|
    	t.integer :ancestor_id, :null => false # id of parent/grandparent
    	t.integer :descendant_id, :null => false # id of target comment
    	t.integer :generations, :null => false # number of generations between anscetor and descendant
    end

    # for all "progeny of.." selects from database
    add_index :comment_hierarchies, [:ancestor_id, :descendant_id, :generations], :unique => true, :name => "comment_ans_desc_udx"

    # for all "anscetors of.." selects from database
    add_index :comment_hierarchies, [:descendant_id], :name => "comment_desc_idx"
  end
end
