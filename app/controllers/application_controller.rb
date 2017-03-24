class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include ApplicationHelper
  include SessionsHelper

  private

  def authenticate
  	redirect_to root_path unless current_user
  end

end
