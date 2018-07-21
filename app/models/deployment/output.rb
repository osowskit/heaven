# Top-level class for Deployments.
class Deployment
  # All of the process output from a deployment
  class Output
    include ApiClient
    attr_accessor :gist, :guid, :name, :number, :stderr, :stdout

    def initialize(name, number, guid, installation_id)
      @guid   = guid
      @name   = name
      @number = number
      @stdout = ""
      @stderr = ""
      @installation_id = installation_id
    end

    def gist
      # Disable for now
      return nil
      @gist ||= api(@installation_id).create_gist(create_params)
    end

    def create
      gist
    end

    def update
      # disable Gist for now
      Rails.logger.info update_params
      return
      
      api(@installation_id).edit_gist(gist.id, update_params)
    rescue Octokit::UnprocessableEntity
      Rails.logger.info "Unable to update #{gist.id}, shit's fucked up."
    rescue StandardError => e
      Rails.logger.info "Unable to update #{gist.id}, #{e.class.name} - #{e.message}."
    end

    def url
      return nil
      gist.html_url
    end

    private

    def create_params
      {
        :files       => { :stdout => { :content => "Deployment #{number} pending" } },
        :public      => false,
        :description => "Heaven number #{number} for #{name}"
      }
    end

    def update_params
      params = {
        :files  => {},
        :public => false
      }

      unless stderr.empty?
        params[:files].merge!(:stderr => { :content => stderr })
      end

      unless stdout.empty?
        params[:files].merge!(:stdout => { :content => stdout })
      end

      params
    end
  end
end
