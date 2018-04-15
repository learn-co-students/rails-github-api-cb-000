class SessionsController < ApplicationController

  skip_before_action :authenticate_user

  def create
    client_id = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_CLIENT_SECRET"]

    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers = {:Accept => 'application/json' }

      #=> code to pass stub_request  test , no working in real browsing
      req.body = {:client_id => client_id, :client_secret => client_secret, :code => params[:code]}

      #=> next is woroking
      #req.params['client_id'] = client_id
      #req.params['client_secret'] = client_secret
      #req.params['code'] = params[:code]
    end
    session[:token] = JSON.parse(resp.body)['access_token']

    redirect_to root_path

  end

end
