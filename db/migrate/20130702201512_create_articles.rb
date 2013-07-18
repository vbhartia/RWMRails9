class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :headline
      t.text :content
      t.string :image_url
      t.string :original_url
      t.integer :user_id
      t.timestamps

    end
    add_index :articles , :user_id
  end

  def self.down
    drop_table :articles
  end
end
