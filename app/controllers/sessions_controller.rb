class SessionsController < ApplicationController

	before_action :authenticate, only: :destroy

	def new
		redirect_to users_path if signed_in?
	end

	def create
		@user = User.find_by(email: params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			sign_in(@user)
			redirect_to users_path
		else
			f(:danger, "Invalid email or password")
			redirect_to root_path
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
