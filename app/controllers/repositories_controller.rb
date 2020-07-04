class RepositoriesController < ApplicationController
  
  def index
    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/vnd.github.v3+json'
    end
    @username = JSON.parse(user_response.body)['login']

    repos_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/vnd.github.v3+json'
    end
    @repos = JSON.parse(repos_response.body)


  end

end
