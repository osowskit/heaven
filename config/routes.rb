Heaven::Application.routes.draw do

  get  "/" => redirect(ENV["ROOT_REDIRECT_URL"] || "https://github.com/atmos/heaven")

  auth_opts =
    if ENV["GITHUB_TEAM_ID"]
        { :team => :employees }
    elsif ENV["GITHUB_ORG"]
        { :org => ENV["GITHUB_ORG"] }
    else
        { }
    end

  github_authenticate(auth_opts) do
    mount Resque::Server.new, :at => "/resque"
  end

  get  "/login" => "users#login"

  get "/auth/heroku/callback" => "users#token"

  get "/user" => "users#show"

  get "/postinstall" => "users#postinstall"

  post "/events" => "events#create"
end
