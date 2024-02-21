# frozen_string_literal: true

RSpec.describe Gumroad::Client do
  context "Products API" do
    context "GET /products" do
      it "returns array of Products", { vcr: "products_list" } do
        result = Gumroad::Product.list

        expect(result).to be_an_instance_of(Array)
        expect(result.first).to be_an_instance_of(Gumroad::Product)
      end
    end

    context "GET /products/:id" do
      it "returns the Product with given id", { vcr: "products_retrieve" } do
        result = Gumroad::Product.retrieve("YYOJtRpx6JzMljfZrf7ADQ==")

        expect(result).to be_an_instance_of(Gumroad::Product)

        expect(result.id).to eq("YYOJtRpx6JzMljfZrf7ADQ==")
      end
    end

    context "DELETE /products/:id/delete" do
      it "deletes the Product with given id", { vcr: "products_delete" } do
        result = Gumroad::Product.destroy("RmW-vcF9RRkzXn_nRq8XBg==")

        expect(result).to be_an_instance_of(Gumroad::Message)

        expect(result.success).to eq(true)
      end
    end

    context "PUT /products/:id/enable" do
      it "enables the Product with given id", { vcr: "products_enable" } do
        result = Gumroad::Product.enable("YYOJtRpx6JzMljfZrf7ADQ==")

        expect(result).to be_an_instance_of(Gumroad::Product)

        expect(result.id).to eq("YYOJtRpx6JzMljfZrf7ADQ==")
      end
    end

    context "PUT /products/:id/disable" do
      it "disables the Product with given id", { vcr: "products_disable" } do
        result = Gumroad::Product.disable("YYOJtRpx6JzMljfZrf7ADQ==")

        expect(result).to be_an_instance_of(Gumroad::Product)

        expect(result.id).to eq("YYOJtRpx6JzMljfZrf7ADQ==")
      end
    end
  end
end
