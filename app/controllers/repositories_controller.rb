class RepositoriesController < ApplicationController

  def index
    client_id = "dummy_id"
    client_secret = "dummy_secret"

    response = Faraday.get "https://api.github.com/user" do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret }
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    body = JSON.parse(response.body)
    @username = body['login']
    response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret }
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(response.body)
  end

end
