class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :title, :body

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname

	has_many :articles

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :comments

end
