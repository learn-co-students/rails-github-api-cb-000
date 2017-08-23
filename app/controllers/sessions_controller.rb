class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get "https://github.com/login/oauth/access_token" do |req|
      req.params["client_id"] = ENV["GITHUB_CLIENT_ID"]
      req.params["client_secret"] = ENV["GITHUB_SECRET"]
      req.params["grant_type"] = "authorization_code"
      req.params["redirect_uri"] = "http://localhost:3000/auth"
      req.params["code"] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    user_resp = Faraday.get('https://api.github.com/user') do |r|
      r.headers['Authorization'] = "token #{ session[:token] }"
      r.headers['Accept'] = 'application/json'
    end

    #remember to clear cache when testing!!
    user_json = JSON.parse(user_resp.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end
end
