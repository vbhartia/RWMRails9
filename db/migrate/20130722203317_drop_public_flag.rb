class DropPublicFlag < ActiveRecord::Migration
  def up
  	remove_column :articles, :public
  end

  def down
  end
end
