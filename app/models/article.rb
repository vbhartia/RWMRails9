class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments

  attr_accessible :headline, :content, :imageURL, :originalURL, :user_id

  after_save :generate_slug

  def to_param
    slug
  end

  def generate_slug
    if (!self.slug) 
		slug_string = id.to_s + '-' + self.headline.parameterize
    	self.slug ||= slug_string
	    self.save
	    puts 'after save'
 	end

  end

  def to_param
    "#{id}-#{headline}".parameterize
  end

end
