class User < ActiveRecord::Base

	validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
	validates :email, presence: true, format: { with: /\A\S+@.+\.\S+\z/ }, uniqueness: true
	validates :password, length: { minimum: 3 }

	has_secure_password

end
