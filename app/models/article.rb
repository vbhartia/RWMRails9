class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments

  attr_accessible :headline, :content, :imageURL, :originalURL, :user_id


  def to_param
    "#{id}-#{headline}".parameterize
  end

end
