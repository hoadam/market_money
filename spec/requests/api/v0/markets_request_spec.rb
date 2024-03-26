require 'rails_helper'

describe "Markets Endpoints" do
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
    @vm_1_2 = @market_1.market_vendors.create(vendor: @vendor_2)
    @vm_1_3 = @market_1.market_vendors.create(vendor: @vendor_3)
    @vm_1_4 = @market_1.market_vendors.create(vendor: @vendor_4)
  end

  it "sends a list of all markets adding the vendor_count attribute to each market" do
    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(markets.count).to eq(5)
    expect(markets).to be_an(Array)

    markets.each do |market|
      expect(market[:attributes]).to have_key(:id)
      expect(market[:attributes][:id]).to be_an(Integer)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)
      
      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)
      
      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_an(Integer)
    end
  end
end