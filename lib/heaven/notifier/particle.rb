require "heaven/comparison/linked"
require 'rest_client'

module Heaven
  module Notifier
    # A notifier for Slack
    class Particle < Notifier::Default
      def deliver(message)
        Rails.logger.info "particle: #{default_message}"
        Rails.logger.info "message: #{message}"

        url = "https://api.particle.io/v1/devices/#{particle_device}/led?access_token=#{particle_token}"

        header = {
          user_agent: "heaven-github-app" 
        }
        begin
          puts "got here"
          result = RestClient.post(url, {arg: 'on'}, header)
        rescue => e
          puts e
        end
        

        Rails.logger.info "particle: result #{result}"
      end

      def default_message
        message = "IOT: no text output"
      end
  
      def particle_device
        ENV["PARTICLE_DEVICE"]
      end

      def particle_token
        ENV["PARTICLE_TOKEN"]
      end
    end
  end
end
