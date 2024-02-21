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
  end

  class Product < Client
    attr_accessor :id, :name, :description, :price, :currency, :url, :thumbnail_url, :custom_fields

    def initialize(attributes = {})
      super()

      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def self.list
      handle_resource_response get("/products")
    end

    def self.retrieve(id)
      handle_resource_response get("/products/%s" % id)
    end

    def self.destroy(id)
      handle_delete_response delete("/products/%s" % id)
    end

    def self.enable(id)
      handle_resource_response put("/products/%s/enable" % id)
    end

    def self.disable(id)
      handle_resource_response put("/products/%s/disable" % id)
    end

    private

    def self.handle_delete_response(response)
      if response.success?
        Message.new(response)
      else
        raise response
      end
    end

    def self.handle_resource_response(response)
      if response.success? && response["success"]
        convert_to_resource_object(response)
      elsif response.success? && !response["success"]
        Message.new(response)
      else
        raise response.response
      end
    end

    def self.convert_to_resource_object(response)
      if response["products"]
        response["products"].map { |product| new(product) }
      else
        new(response["product"])
      end
    end
  end
end
