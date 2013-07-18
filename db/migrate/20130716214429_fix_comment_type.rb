class FixCommentType < ActiveRecord::Migration
  def change
    remove_column :comments, :type
    add_column :comments, :comment_type, :string
  
  end
end
