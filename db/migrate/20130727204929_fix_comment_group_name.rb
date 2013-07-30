class FixCommentGroupName < ActiveRecord::Migration
  def change
  	remove_column :comments, :comment_group
  	add_column :comments, :group_comment_id, :integer
  end

end
