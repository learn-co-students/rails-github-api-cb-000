class RepositoriesController < ApplicationController
  def index
    # Should really be done in one request but who cares? :P
    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @username = JSON.parse(user_resp.body)['login']

    repos_resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(repos_resp.body)
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = {
        'name': params[:name]
      }.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    redirect_to root_path
  end
end
