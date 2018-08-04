# Top-level class for Deployments.
class Deployment
  # All of the process output from a deployment
  class Checks
    include ApiClient
    attr_accessor :check_run, :check_suite, :sha, :title, :installation_id, :repo_fullname, :environment, :stderr, :stdout

    def initialize(repo_fullname, number, sha, environment, installation_id)
      @repo_fullname = repo_fullname
      @number = number
      @sha    = sha
      @environment = environment
      @installation_id = installation_id
      @stdout = ""
      @stderr = ""
    end

    def check_run
      @check_run ||= create_check_run(installation_id, repo_fullname, create_params)
    end
    
    def create
      @check_run = create_check_run(installation_id, repo_fullname, create_params)
    end

    def check_run_id
      check_run["id"]
    end

    def update(conclusion)
      # disable Gist for now
      Rails.logger.info update_params(conclusion)
      
      update_check_run(installation_id, repo_fullname, check_run_id, update_params(conclusion))
    end

    def url
      return nil
      gist.html_url
    end

    private

    def create_params
      {
        :name        => "Deployment : #{environment}",
        :head_sha    => @sha,
        :status      => "in_progress",
        :output      => { 
            :title   => "Deploying to #{environment}",
            :summary => "Deployment #{@number}",
            :text    => "Heaven number #{@number} for #{@repo_fullname}"
        }
      }
    end

    def update_params(conclusion)
      puts "updating params"
      params = {
        :status => "completed",
        :conclusion => conclusion,
        :completed_at => Time.now.iso8601,
        :output   => {
          :title   => "Deploying to #{environment}",
          :summary => "Deployment #{@number}",
          :text    => "Heaven number #{@number} for #{@repo_fullname}"
        }
      }
      
      unless stderr.empty?
        params[:output].merge!({ :text => stderr })
      end

      unless stdout.empty?
        params[:output].merge!({ :text => stdout })
      end

      puts params

      params
    end

  end
end
