class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @username = JSON.parse(user_resp.body)["login"]
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repositories = JSON.parse(resp.body)
  end

  def create
    response = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = {'name': params[:name]}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    redirect_to root_path
  end
end
