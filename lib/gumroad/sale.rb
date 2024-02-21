module Gumroad
  # Represents a Sale resource from the Gumroad API.
  # For more information, refer to the Gumroad API documentation on Products:
  # https://gumroad.com/api#sales
  class Sale < Resource
    # Lists all sales associated with the Gumroad account.
    # @see https://app.gumroad.com/api#get-/sales
    # @param params [Hash] a hash of query parameters to filter the list of sales.
    #   @option params [String] :after (optional) Only return sales after this date in the form YYYY-MM-DD.
    #   @option params [String] :before (optional) Only return sales before this date in the form YYYY-MM-DD.
    #   @option params [String] :product_id (optional) Filter sales by this product ID.
    #   @option params [String] :email (optional) Filter sales by this email.
    #   @option params [String] :order_id (optional) Filter sales by this Order ID.
    #   @option params [String] :page_key (optional) A key representing a page of results, provided in the response as `next_page_key`.
    # @return [Array[Array<Product>, String] an array of Sale instances and the next page key as tuple.
    # @return [Message] when the request fails.
    def self.list(params = {})
      handle_resource_response get("/sales", query: params)
    end

    # Retrieves the details of a single sale by its ID.
    # @see https://app.gumroad.com/api#get-/sales/:id
    # @param id [String] the ID of the sale to retrieve.
    # @return [Sale] an instance of Sale with the retrieved details.
    def self.retrieve(id)
      handle_resource_response get("/sales/%s" % id)
    end

    # Marks a sale as shipped. Available with the 'mark_sales_as_shipped' scope.
    # @see https://app.gumroad.com/api#put-/sales/:id/mark_as_shipped
    # @param id [String] the ID of the sale to mark as shipped.
    # @param params [Hash] a hash of parameters to mark the sale as shipped.
    #  @option params [String] :tracking_number (optional) The tracking number for the shipment.
    # @return [Sale] the updated Sale instance, marked as shipped.
    def self.mark_as_shipped(id, params = {})
      handle_resource_response put("/sales/%s/mark_as_shipped" % id, body: params)
    end

    # Refunds a sale. Available with the 'refund_sales' scope.
    # @see https://app.gumroad.com/api#put-/sales/:id/refund
    # @param id [String] the ID of the sale to refund.
    # @param params [Hash] a hash of parameters to refund the sale.
    # @option params [String] :amount_cents (optional) The amount to refund.
    # @return [Sale] the updated Sale instance, marked as refunded.
    def self.refund(id, params = {})
      handle_resource_response put("/sales/%s/refund" % id, body: params)
    end

    # @return [anything]
    def self.convert_to_resource_object(response)
      if response["sales"]
        [response["sales"].map { |product| new(product) }, response["next_page_key"]]
      else
        new(response["sale"])
      end
    end
  end
end
