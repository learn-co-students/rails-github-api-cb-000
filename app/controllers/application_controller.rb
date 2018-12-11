class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    
    client_id = ENV['CLIENT_ID']
    # redirect_uri = CGI.escape("http://159.89.134.39:44961/auth")
    github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=user%20public_repo"
    redirect_to github_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
