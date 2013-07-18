class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  has_many :comments

  attr_accessible :headline, :content, :imageURL, :originalURL, :user_id
end
