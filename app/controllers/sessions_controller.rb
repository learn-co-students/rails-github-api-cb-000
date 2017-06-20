class SessionsController < ApplicationController
	skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    redirect_to '/'

    # resp = Faraday.post('https://github.com/login/oauth/access_token') do |r|
    #   r.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    #   r.params['client_secret'] = ENV['GITHUB_SECRET']
    #   r.params['code'] = params[:code]
    #   r.headers['Accept'] = 'application/json'
    # end
    # body = JSON.parse(resp.body)
    # session[:token] = body["access_token"]

    # user_resp = Faraday.get('https://api.github.com/user') do |r|
    #   r.headers['Authorization'] = "token #{ session[:token] }"
    #   r.headers['Accept'] = 'application/json'
    # end

    # #remember to clear cache when testing!!
    # user_json = JSON.parse(user_resp.body)
    # session[:username] = user_json["login"]

    # redirect_to root_path
  end

end