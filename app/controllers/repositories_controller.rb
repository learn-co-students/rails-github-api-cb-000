class RepositoriesController < ApplicationController
  def index
      user_repo = Faraday.get("https://api.github.com/user/repos") do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
        req.headers['Accept'] = 'application/json'
      end
      @repos = JSON.parse(user_repo.body)


    end

    def create

      r = {:name => "#{params[:name]}"}.to_json
        new_repo = Faraday.post("https://api.github.com/user/repos") do |req|

        req.headers['Authorization'] = "token #{session[:token]}"
        req.headers['Accept'] = 'application/json'
        req.body = r
      end

    
      redirect_to '/'
end

end
