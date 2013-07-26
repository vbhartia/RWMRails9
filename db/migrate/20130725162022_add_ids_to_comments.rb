class AddIdsToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :comment_location_ids, :string
  end
end
