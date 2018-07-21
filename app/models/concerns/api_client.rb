# A module to include for easy access to the GitHub API
require 'jwt'
require "active_support/core_ext/numeric/time"

module ApiClient
  extend ActiveSupport::Concern

  def github_token(installation_id)
    @jwt_client = Octokit::Client.new(:bearer_token => get_jwt, :api_endpoint => github_api_endpoint, :accept => "application/vnd.github.machine-man-preview+json")  
    access_token = @jwt_client.create_app_installation_access_token(installation_id, :api_endpoint => github_api_endpoint, :accept => "application/vnd.github.machine-man-preview+json")
    access_token.token
  end

  def github_client_id
    ENV["GITHUB_CLIENT_ID"] || "<unknown-client-id>"
  end

  def github_client_secret
    ENV["GITHUB_CLIENT_SECRET"] || "<unknown-client-secret>"
  end

  def github_api_endpoint
    ENV["OCTOKIT_API_ENDPOINT"] || "https://api.github.com/"
  end

  # GitHub App private key
  def github_app_key
    if Rails.env.development?
      File.read(ENV["GITHUB_KEY_LOCATION"])
    else
      ENV["GITHUB_APP_KEY"]
    end
  end
  
  def get_jwt
    private_key = OpenSSL::PKey::RSA.new(github_app_key)

    payload = {
      # issued at time
      iat: Time.now.to_i,
      # JWT expiration time (10 minute maximum)
      exp: 5.minutes.from_now.to_i,
      # Integration's GitHub identifier
      iss: github_app_id
    }

    JWT.encode(payload, private_key, "RS256")
  end

  def github_app_id
    ENV["GITHUB_APP_ID"] || "<unknown-app-id>"
  end

  


  def api(installation_id)
    access_token = github_token(installation_id)
    @api = Octokit::Client.new(:access_token => access_token,
                                 :api_endpoint => github_api_endpoint)
  end

  def oauth_client_api
    @oauth_client_api ||= Octokit::Client.new(
      :client_id     => github_client_id,
      :client_secret => github_client_secret,
      :api_endpoint  => github_api_endpoint
    )
  end
end
