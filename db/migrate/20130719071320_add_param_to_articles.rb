class AddParamToArticles < ActiveRecord::Migration
  def change
    add_column :articles , :description, :text
    add_column :articles , :author, :string
    add_column :articles , :site_name, :string
  end
end
