class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_secure_password

    validates :name, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password_digest, presence: true
    
end
