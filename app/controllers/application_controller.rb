class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  private

  def authenticate
  	redirect_to root_path unless current_user
  end

end
