class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |r|
      r.headers = { 'Authorization' => "token #{session[:token]}", 'Accept' => "application/json"}
    end
    repo_body = JSON.parse(resp.body)
    @repos = repo_body
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |r|
      r.headers = { 'Authorization' => "token #{session[:token]}", 'Accept' => "application/json"}
      r.body = { name: params[:name] }.to_json
    end

    redirect_to root_path
  end
end
