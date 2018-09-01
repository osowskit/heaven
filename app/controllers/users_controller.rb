# A controller to handle incoming webhook events
class UsersController < ActionController::Base

  def token
    session[:heroku_oauth_token] =
      request.env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/user"
  end
  
  def login
    render inline: "<html><a href='/auth/heroku'>Sign in with Heroku</a>
    </html>"
  end

  def postinstall
    session[:installation_id]
  end

  def show
    if !session[:heroku_oauth_token]
      redirect_to "/login"
    else
      puts session[:heroku_oauth_token]
      api = Excon.new(ENV["HEROKU_API_URL"] || "https://api.heroku.com",
        headers: { "Authorization" => "Bearer #{session[:heroku_oauth_token]}",
            "Accept" => "application/vnd.heroku+json; version=3"},
        ssl_verify_peer: ENV["SSL_VERIFY_PEER"] != "false")
      res = api.get(path: "/account", expects: 200)
      user_email = JSON.parse(res.body)["email"]

      render inline: "<HTML>Hi #{CGI.escapeHTML(user_email)} </HTML>"
    end
  end
end
