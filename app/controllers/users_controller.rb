# A controller to handle incoming webhook events
class UsersController < ActionController::Base
  include ApiClient

  def token
    session[:heroku_oauth_token] =
      request.env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/user"
  end
  
  def login
    render inline: "<html><a href='/auth/heroku'>Sign in with Heroku</a>
    </html>"
  end
  
  def clear
    session[:heroku_oauth_token]
    redirect_to "/login"
  end

  def postinstall
    session[:installation_id] = params[:installation_id]
    redirect_to "/login"
  end

  def show
    if !session[:heroku_oauth_token]
      redirect_to "/login"
    else
      # Query all Repos for session[:installation_id]
      # Add session[:heroku_oauth_token] as Config
      @client = api(session[:installation_id])
      response = @client.list_installation_repos
      response.repositories.each do | repo |
        encrypted_data = encrypt!(session[:heroku_oauth_token], repo.id, session[:installation_id])
        set_config(session[:installation_id], repo.full_name, "heroku_oauth_token", encrypted_data)
      end

      api = Excon.new(ENV["HEROKU_API_URL"] || "https://api.heroku.com",
        headers: { "Authorization" => "Bearer #{session[:heroku_oauth_token]}",
            "Accept" => "application/vnd.heroku+json; version=3"},
        ssl_verify_peer: ENV["SSL_VERIFY_PEER"] != "false")
      res = api.get(path: "/account", expects: 200)
      user_email = JSON.parse(res.body)["email"]

      render inline: "<HTML>Hi #{CGI.escapeHTML(user_email)} #{CGI.escapeHTML(session[:heroku_oauth_token])}</HTML>"
    end
  end
end
