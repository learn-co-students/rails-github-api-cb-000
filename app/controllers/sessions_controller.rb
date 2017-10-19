class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    get_token = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['client_id']
      req.params['client_secret'] = ENV['client_secret']
      req.params['code'] = params[:code]
      req.headers['Accept'] = 'application/json'

    end
     token_response = JSON.parse(get_token.body)
     session[:token] = token_response["access_token"]

     user = Faraday.get("https://api.github.com/user") do |req|
       req.headers['Authorization'] = "token #{session[:token]}"
       req.headers['Accept'] = 'application/json'

     end

     user_hash = JSON.parse(user.body)
    
     session[:username] = user_hash["login"]
    redirect_to '/'
  end

end
