class AddCommentGroupToCommment < ActiveRecord::Migration
  def change
  	add_column :comments, :comment_group, :integer
  end
end
