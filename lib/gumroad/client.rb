require 'httparty'

module Gumroad
  class Client
    include HTTParty
    base_uri 'https://api.gumroad.com/v2'

    def self.access_token=(token)
      default_params access_token: token
    end
  end

  class Message
    attr_accessor :success, :message

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def success?
      success
    end
  end


end
