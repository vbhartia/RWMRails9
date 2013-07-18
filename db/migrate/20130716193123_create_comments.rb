class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
		t.belongs_to :user
		t.belongs_to :article
		t.string :type
		t.text :content


      t.timestamps
    end
  end

  def self.down
  	drop_table :comments
  end 

end
