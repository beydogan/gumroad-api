module Gumroad
  # Represents a Product resource from the Gumroad API.
  # For more information, refer to the Gumroad API documentation on Products:
  # https://gumroad.com/api#products
  class Product < Resource
    # Accessors for product attributes
    attr_accessor :id, :name, :description, :price, :currency, :url, :thumbnail_url, :custom_fields

    # Lists all products associated with the Gumroad account.
    # @see https://app.gumroad.com/api#get-/products
    # @return [Array<Product>] an array of Product instances.
    # @return [Message] when the request fails.
    def self.list
      handle_resource_response get("/products")
    end

    # Retrieves the details of a single product by its ID.
    # @see https://app.gumroad.com/api#get-/products/:id
    # @param id [String] the ID of the product to retrieve.
    # @return [Product] an instance of Product with the retrieved details.
    # @return [Message] when the request fails.
    def self.retrieve(id)
      handle_resource_response get("/products/%s" % id)
    end

    # Deletes a product by its ID.
    # @param id [String] the ID of the product to delete.
    # @return [Message] the response from the API after deleting the product.
    def self.destroy(id)
      handle_delete_response delete("/products/%s" % id)
    end

    # Enables a product by its ID, making it available for sale.
    # @param id [String] the ID of the product to enable.
    # @return [Product] the updated Product instance, marked as enabled.
    # @return [Message] when the request fails.
    def self.enable(id)
      handle_resource_response put("/products/%s/enable" % id)
    end

    # Disables a product by its ID, making it unavailable for sale.
    # @param id [String] the ID of the product to disable.
    # @return [Product] the updated Product instance, marked as disabled.
    # @return [Message] when the request fails.
    def self.disable(id)
      handle_resource_response put("/products/%s/disable" % id)
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
