class User < ActiveRecord::Base
  before_create :load_avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :carts
  has_many :tickets
  enum role: [:member, :admin]
  enum gender: [:male, :female]
  enum badge: [:general, :business, :special]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |new_user|
      new_user.name = auth.info.name
      new_user.email = auth.info.email
      new_user.image = auth.info.image
      new_user.password = Devise.friendly_token[0,20]
    end
  end

  private
  def load_avatar
    self.image = "avatar.jpg"
  end
end
