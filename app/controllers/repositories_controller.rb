class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token " + session[:token]
    end

    responseRepos = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token " + session[:token]
    end

    body = JSON.parse(resp.body)
    @bodyRepos = JSON.parse(responseRepos.body)
    @username = body["login"]
  end

end
