class FixColumnTypeOnCommetIds < ActiveRecord::Migration
  def up
  	change_column :comments, :comment_location_ids, :text
  end

  def down
  end
end
