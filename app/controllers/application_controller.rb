class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	include ApplicationHelper
	include SessionsHelper

	private

	def authenticate
		redirect_to sign_in_path unless current_user
	end

end
