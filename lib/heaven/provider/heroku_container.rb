module Heaven
  # Top-level module for providers.
  module Provider

    # A heroku build object.
    class HerokuContainerBuild
      include HerokuApiClient

      attr_accessor :id, :info, :name
      def initialize(name, id)
        @id   = id
        @name = name
        @info = info!
      end

      def info!
        response = http.get do |req|
          req.url "/apps/#{name}/builds/#{id}"
        end
        Rails.logger.info "#{response.status} response for Heroku build info for #{id}"
        @info = JSON.parse(response.body)
      end

      def output
        response = http.get do |req|
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
        Rails.logger.info "Refreshing build #{id}"
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
      include HerokuApiClient

      attr_accessor :build
      def initialize(guid, payload)
        super
        @name = "heroku_container"
      end

      def app_name
        # force new environment
        @name
      end

      def get_docker_tag
        # values_url
        tag = data.inputs[0].attributes.tag
        server = data.inputs[0].attributes.registry.server
        {"tag": tag, "server": server}
      end

      def pull_image
        docker_info = get_docker_tag
        token = github_token(installation_id)
        execute_and_log(["docker", "login", "-u", "token", "-p", token, docker_info["server"]])
        execute_and_log(["docker", "pull", docker_info["tag"]])
      end
      
      def push_image
        docker_info = get_docker_tag
        puts image = %x( docker images -a | grep "#{docker_info["server"]}" | awk '{print $3}' )
        image = image.chomp
        puts tag = %x( docker tag #{image} registry.heroku.com/#{app_name}/web )
        puts login = %x( docker login --username=_ -p "" registry.heroku.com )
        puts push = %x( docker push registry.heroku.com/#{app_name}/web )
      end
      
      def clean_up
        puts value = %x( docker images -a | grep "launch" | awk '{print $3}' | xargs docker rmi -f )
      end
      
      def execute
        status.started!
        app_response = create_app
        @name = JSON.parse(app_response.body)["name"]
        
        pull_image

        response = push_image
        return unless response.success?
        body   = JSON.parse(response.body)
        @build = HerokuBuild.new(@name, body["id"])

        until build.completed?
          sleep 10
          build.refresh!
        end
      end

      def notify
        if build
          output.stderr = build.stderr
          output.stdout = build.stdout
          checkrun.stderr = build.stderr
          checkrun.stdout = build.stdout
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
        http.post do |req|
          req.url "/apps"
          body = {
            :region => "us",
            :stack  => "container"
          }
          req.body = JSON.dump(body)
        end
      end

      def build_request
        push_image
      end
    end
  end
end
