class FixCommentGroupName < ActiveRecord::Migration
  def change
  	remove_column :comments, :comment_group, :integer
  	add_column :comments, :group_comment_id, :integer
  end

end
