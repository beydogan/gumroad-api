# frozen_string_literal: true

RSpec.describe Gumroad::Sale do
  context "#list" do
    it "returns array of Sales", { vcr: "sales_list" } do
      sales, next_page_key = Gumroad::Sale.list

      expect(sales).to be_an_instance_of(Array)
      expect(sales.first).to be_an_instance_of(Gumroad::Sale)
      expect(next_page_key).not_to be_nil
    end
  end

  context "#retrieve" do
    it "returns the Sale with given id", { vcr: "sales_retrieve" } do
      sale = Gumroad::Sale.retrieve("123")

      expect(sale.success?).to eq(true)
      expect(sale).to be_an_instance_of(Gumroad::Sale)
    end
  end

  context "#mark_as_shipped" do
    it "marks the sale as shipped and returns the Sale", { vcr: "sales_mark_as_shipped" } do
      sale = Gumroad::Sale.mark_as_shipped("123", tracking_url: "https://example.com")

      expect(sale.success?).to eq(true)
      expect(sale).to be_an_instance_of(Gumroad::Sale)
      expect(sale.tracking_url).to eq("https://example.com")
      expect(sale.shipped).to eq(true)
    end

    it "success? false when there is an error", { vcr: "sales_mark_as_shipped_error" } do
      sale = Gumroad::Sale.mark_as_shipped("123")

      expect(sale.success?).to eq(false)
    end
  end

  context "#refund" do
    it "refunds the sale", { vcr: "sales_refund" } do
      sale = Gumroad::Sale.refund("123", amount_cents: "200")

      expect(sale.success?).to eq(true)
      expect(sale).to be_an_instance_of(Gumroad::Sale)
      expect(sale.partially_refunded).to eq(true)
    end

    it "success? false when there is an error", { vcr: "sales_refund_error" } do
      sale = Gumroad::Sale.mark_as_shipped("123")

      expect(sale.success?).to eq(false)
    end
  end
end
