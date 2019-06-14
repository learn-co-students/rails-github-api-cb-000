class SessionsController < ApplicationController
  skip_before_action :authenticate_user


# http://localhost:3000/auth routes to a sessions controller. 
# In the sessions controller, we use the Client ID and Client Secret, 
# as well as the code param by sending them in a POST back to GitHub. 
# If this information is correct, GitHub will respond with an access_token.

# In sessions_controller.rb, write a create method. 
# This method should receive GitHub's code parameter and should use it in conjunction 
# with your Client ID and Client Secret to send a POST request to GitHub. 
# The base URL this time will be https://github.com/login/oauth/access_token.


  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params['code'] }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    redirect_to root_path
  end
end


