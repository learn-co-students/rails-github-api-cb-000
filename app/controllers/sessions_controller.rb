class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'
      req.body = {"client_id"=>ENV['GITHUB_CLIENT_ID'], "client_secret" => ENV["GITHUB_CLIENT_SECRET"], "code"=> params[:code]}.to_json
    end
    #This is what I needed to get it to work with Gihub
    #session[:token] = resp.body.split("&")[0].split("=")[1]

    #This is how it worked with the tests.
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
    end
    session[:user] = JSON.parse(resp.body)["login"]

    redirect_to root_path
  end
end
