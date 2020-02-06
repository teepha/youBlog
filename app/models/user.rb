class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  before_save { self.email = email.downcase }
  validates :username, presence: true,
              uniqueness: { case_sensitive: false }, 
              length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: { maximum: 75 },
              uniqueness: { case_sensitive: false }, 
              format: { with: VALID_EMAIL_REGEX }
  validates :biography, length: { maximum: 100 }
  validates_presence_of :password_digest, :on => :create

  has_many :articles, dependent: :destroy
end
 