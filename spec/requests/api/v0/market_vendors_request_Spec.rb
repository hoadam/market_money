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
      post "/api/v0/market_vendors?market=#{@market_1.id}&vendor=#{@vendor_2.id}"
      #/api/v0/markets/#{@market_1.id}/vendors"

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.body).to eq("Vendor added to Market")

      get "/api/v0/vendors"
    end

    #Sad path
    it ""
  end
end