module Heaven
  # Top-level module for providers.
  module Provider
    module HerokuContainerApiClient
      def http_options(token)
        {
          :url     => "https://api.heroku.com",
          :headers => {
            "Accept"        => "application/vnd.heroku+json; version=3.docker-releases",
            "Content-Type"  => "application/json",
            "Authorization" => "Bearer #{token}",
            "Range" => "version ..; max=1, order=desc"
          }
        }
      end

      def http(token)
        @http ||= Faraday.new(http_options(token)) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
          faraday.response :logger unless %w{staging production}.include?(Rails.env)
        end
      end
    end

    # A heroku build object.
    class HerokuRelease
      include HerokuContainerApiClient
      include ApiClient

      attr_accessor :release_id, :image_digest, :info, :name, :process
      def initialize(name, image_digest, token, process="web")
        @image_digest = image_digest
        @name = name
        @token = token
        @process = process
        response = release!
        @release_id = response[0]["id"]
        @info = info!
      end

      def info!
        response = http(@token).get do |req|
          req.url "/apps/#{name}/releases"
        end
        Rails.logger.info "#{response.status} response for Heroku release info for #{@release_id}"
        @info = JSON.parse(response.body).first
      end

      def release!
        response = http(@token).patch do |req|
          req.url "/apps/#{name}/formation"
          body = {
            :updates => [
              {
                :type => "#{@process}",
                :docker_image => "#{image_digest}"
              }
             ]
          }
          puts "request body"
          puts JSON.dump(body)
          req.body = JSON.dump(body)
        end
        JSON.parse(response.body)
      end
      
      def output
        response = http(@token).get do |req|
          req.url "/apps/#{name}/builds/#{id}/result"
        end
        Rails.logger.info "#{response.status} response for Heroku build output for #{id}"
        @output = JSON.parse(response.body)
      end

      def lines
        @lines ||= output["lines"]
      end

      def stdout
        lines.map do |line|
          line["line"] if line["stream"] == "STDOUT"
        end.join
      end

      def stderr
        lines.map do |line|
          line["line"] if line["stream"] == "STDERR"
        end.join
      end

      def refresh!
        Rails.logger.info "Refreshing release #{id}"
        info!
      end

      def completed?
        success? || failed?
      end

      def success?
        info["status"] == "succeeded"
      end

      def failed?
        info["status"] == "failed"
      end
    end

    # The heroku provider.
    class HerokuContainerHeavenProvider < DefaultProvider
      include HerokuContainerApiClient

      attr_accessor :build
      def initialize(guid, payload)
        super
        @name = "heroku_container"
        puts "initialize"
        puts @token = get_config(installation_id, name_with_owner, "heroku_oauth_token")
      end

      def app_name
        # force new environment
        @name
      end

      def get_docker_tag
        # values_url
        # look up Values API tag :(
        puts server = custom_payload["server"]
        puts tag = custom_payload["tag"]
        
        #tag = data.inputs[0].attributes.tag
        #server = data.inputs[0].attributes.registry.server
        {"tag": tag, "server": server}
      end

      def pull_image  
        docker_info = get_docker_tag
        token = github_token(installation_id)
        puts image = %x( docker login -u token -p "#{token}" "#{docker_info[:server]}")
        #execute_and_log(["docker", "login", "-u", "token", "-p", token, docker_info[:server]])
        puts pull = %x( docker pull "#{docker_info[:tag]}")
      end
      
      def push_image
        # Get from GitHub
        docker_info = get_docker_tag
        puts image = %x( docker images -a | grep "#{docker_info[:server]}" | awk '{print $3}' )
        image = image.chomp
        puts tag = %x( docker tag #{image} registry.heroku.com/#{app_name}/web )
        
        # Push to Heroku
        puts login = %x( docker login --username=_ -p "#{@token}" registry.heroku.com )
        push_output = %x( docker push registry.heroku.com/#{app_name}/web )
        image_sha = %x( docker image inspect "#{image}" -f '{{ .Id }}' )
        image_sha.chomp
      end
      
      def clean_up
        puts value = %x( docker images -a | grep "launch" | awk '{print $3}' | xargs docker rmi -f )
      end
      
      def execute
        status.started!

        puts app_response = create_app
        puts @name = app_response["name"]
        app_id =  app_response["id"]

        pull_image
        image_digest = push_image
        @release = HerokuRelease.new(@name, image_digest, @token)

        until @release.completed?
          sleep 10
          @release.refresh!
        end
      end

      def notify
        if @release
          message = "Success #{@name}.herokuapp.com"
          output.stderr = message
          output.stdout = message
          checkrun.stderr = message
          checkrun.stdout = message
        else
          output.stderr = "Unable to create a build"
          checkrun.stderr = "Unable to create a build"
        end

        output.update
        checkrun.update("neutral")
        if build && build.success?
          status.success!
        else
          status.failure!
        end
      end

      private

      def create_app
        response = http(@token).post do |req|
          req.url "/apps"
          body = {
            :region => "us",
            :stack  => "container"
          }
          req.body = JSON.dump(body)
        end
        JSON.parse(response.body)
      end

      def build_request
        push_image
      end
    end
  end
end
