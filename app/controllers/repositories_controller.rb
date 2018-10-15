class RepositoriesController < ApplicationController

  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user_data = JSON.parse(user.body)

    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(repos.body)


  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = { 'name': params[:name] }.to_json
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
      # req.body = {
      #   "name": params['name'],
      #   "description": "This is your first repository",
      #   "private": false
      # }.to_json
    end
    body = JSON.parse(resp.body)

    binding.pry
    redirect_to root_path
  end

end
