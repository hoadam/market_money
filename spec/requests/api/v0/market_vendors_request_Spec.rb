require 'rails_helper'

describe "Market Vendors Endpoints" do
  before do
    @market_1 = create(:market)

    @vendor_1 = create(:vendor)
    @vendor_2 = create(:vendor)

    @vm_1_1 = @market_1.market_vendors.create(vendor: @vendor_1)
  end

  describe "Create market vendors" do
    it "creates a market vendor, sends a 201 status response detailing that a vendor was added to a market" do
      post "/api/v0/market_vendors", params: {"market_id":"#{@market_1.id}", "vendor_id":"#{@vendor_2.id}"}

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)['message']).to eq("Vendor added to Market")

      get "/api/v0/markets/#{@market_1.id}/vendors"

      market_vendors = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(market_vendors.any? { |mv| mv[:id] == "#{@vendor_2.id}" }).to eq(true)
    end

    #Sad paths
    it "sends a 404 status response when an invalid vendor id is passed in" do
      post "/api/v0/market_vendors", params: {"market_id":"#{@market_1.id}", "vendor_id":"12341234"}

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end

    it "sends a 404 status response when an invalid  market id is passed in" do
      post "/api/v0/market_vendors", params: {"market_id":"12341234", "vendor_id":"#{@market_1.id}"}

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end

    it "sends a 400 status response and detailed message when a vendor id and/or a market id are not passed in" do
      post "/api/v0/market_vendors", params: {"market_id":"12341234"}

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['errors']).to eq("Both market_id and vendor_id are required")
    end

    it "sends a 422 status response and detailed message when a market vendor association for the passed params already exists" do
      @vm_1_1 = @market_1.market_vendors.create(vendor: @vendor_1)
      
      post "/api/v0/market_vendors", params: {"market_id":"#{@market_1.id}", "vendor_id":"#{@vendor_1.id}"}

      expect(response).not_to be_successful
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['errors']).to include("Validation failed: Market vendor asociation between market with market_id=#{@market_1.id} and vendor_id=#{@vendor_1.id} already exists")
    end
  end

  describe "Delete market vendors" do
    it "destroys an existing market vendors when it finds one and sends a 204 status" do

      @vm_1_2 = @market_1.market_vendors.create(vendor: @vendor_2)

      delete "/api/v0/market_vendors", params: {"market_id":"#{@market_1.id}", "vendor_id":"#{@vendor_2.id}"}

      expect(response).to be_successful
      expect(response.status).to eq(204)

      get "/api/v0/markets/#{@market_1.id}/vendors"
      market_vendors = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(market_vendors.any? { |mv| mv[:id] == "#{@vendor_2.id}" }).to eq(false)
    end

    #Sad path
    it "sends a 404 status and a descriptive message when a marketvendor resource is not found" do
      delete "/api/v0/market_vendors", params: {"market_id":4233, "vendor_id":11520}

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['errors']).to eq("No MarketVendor with market_id=4233 AND vendor_id=11520 exists")
    end
  end
end