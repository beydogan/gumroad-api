module Gumroad
  class Resource < Client
    attr_accessor :id, :name, :description, :price, :currency, :url, :thumbnail_url, :custom_fields

    def initialize(attributes = {})
      super()

      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def self.handle_delete_response(response)
      raise response unless response.success?

      Message.new(response)
    end

    # @return anything
    def self.handle_resource_response(response)
      if response.success? && response["success"]
        convert_to_resource_object(response)
      elsif response.success? && !response["success"]
        Message.new(response)
      else
        raise response.response
      end
    end
  end
end