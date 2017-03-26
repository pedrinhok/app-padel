module SpecHelper

	def sign_in user
		post :create, { session: { email: user.email, password: user.password } }
	end

end