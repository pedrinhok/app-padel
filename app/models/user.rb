class User < ActiveRecord::Base

	validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
	validates :email, presence: true, format: { with: /\A\S+@.+\.\S+\z/ }, uniqueness: true

	has_secure_password

end
