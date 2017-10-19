class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  private

    def authenticate_user
      git_hub = "https://github.com/login/oauth/authorize?client_id=#{ENV['client_id']}&scope=repo"

      redirect_to git_hub unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
