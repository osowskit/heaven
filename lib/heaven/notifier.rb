require "heaven/notifier/default"
require "heaven/notifier/campfire"
require "heaven/notifier/hipchat"
require "heaven/notifier/flowdock"
require "heaven/notifier/slack"
require "heaven/notifier/particle"

module Heaven
  # The Notifier module
  module Notifier
    def self.for(payload)
      
      Rails.logger.info "Selecting Notifier"
      # @data = payload
      @default = ::Heaven::Notifier::Default.new(payload)
      
      if slack?
        ::Heaven::Notifier::Slack.new(payload)
      elsif particle?
        ::Heaven::Notifier::Particle.new(payload)
      elsif hipchat?
        ::Heaven::Notifier::Hipchat.new(payload)
      elsif flowdock?
        ::Heaven::Notifier::Flowdock.new(payload)
      elsif campfire?
        ::Heaven::Notifier::Campfire.new(payload)
      else
        # noop on posting
      end
    end

    def self.installation_id
      @default.installation_id
      # @data["installation"]["id"]
    end
 
    def self.name_with_owner
      @default.name_with_owner
    end
 
    def self.particle?
      !ENV["PARTICLE_TOKEN"].nil? || !@default.get_config(installation_id, name_with_owner, "PARTICLE_TOKEN").nil?
    end

    def self.slack?
      !ENV["SLACK_WEBHOOK_URL"].nil? || !@default.get_config(installation_id, name_with_owner, "SLACK_WEBHOOK_URL").nil?
    end

    def self.hipchat?
      !ENV["HIPCHAT_TOKEN"].nil?
    end

    def self.flowdock?
      !ENV["FLOWDOCK_USER_API_TOKEN"].nil?
    end

    def self.campfire?
      !ENV["CAMPFIRE_TOKEN"].nil?
    end
  end
end
