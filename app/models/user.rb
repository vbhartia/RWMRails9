class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :title, :body

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname

	has_many :articles

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :comments

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.username ='Linda'
      user.firstname = auth.info.name
      user.lastname = '1234'
      user.email =auth.info.email
      user.password = 'abcdef'

      user.save!
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def password_required?
    super && provider.blank?
  end


end
