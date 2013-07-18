class AddFacebookToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :oauth_token, :string
    add_column :users, :provider, :string
  end
end
