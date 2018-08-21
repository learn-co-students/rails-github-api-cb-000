class RepositoriesController < ApplicationController
  def index
    user = Faraday.get "https://api.github.com/user" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @username = JSON.parse(user.body)['login']

    repos = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repositories = JSON.parse(repos.body)

  end

  def create
    response = Faraday.post "https://api.github.com/user/repos" do |req|
      req.body = { 'name': params[:name] }.to_json
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    redirect_to '/'
  end

end
