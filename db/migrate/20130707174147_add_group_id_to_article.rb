class AddGroupIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles , :group_id, :integer
    add_index :articles , :group_id
  end
end
