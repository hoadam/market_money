require 'rails_helper'

describe "Market Vendors Endpoints" do
  before do
    @market_1 = create(:market)
    @market_2 = create(:market)
    @market_3 = create(:market)
    @market_4 = create(:market)
    @market_5 = create(:market)

    @vendor_1 = create(:vendor)
    @vendor_2 = create(:vendor)
    @vendor_3 = create(:vendor)
    @vendor_4 = create(:vendor)
    @vendor_5 = create(:vendor)

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

      market_vendors.include?(@vendor_2)
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
      expect(JSON.parse(response.body)['error']).to eq("Both market_id and vendor_id are required")
    end
  end
end