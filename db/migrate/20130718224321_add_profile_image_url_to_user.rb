class AddProfileImageUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_image_url, :string
  end
end
