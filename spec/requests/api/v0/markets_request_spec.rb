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
    @vm_2_5 = @market_2.market_vendors.create(vendor: @vendor_5)
  end

  describe "Market index" do
    it "sends a list of all markets adding the vendor_count attribute to each market" do
      get '/api/v0/markets'

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(markets.count).to eq(5)
      expect(markets).to be_an(Array)

      markets.each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_a(String)

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

  describe "Market show" do
    it "returns all market attributes when a market id is passed in" do
      get "/api/v0/markets/#{@market_1.id}"

      expect(response).to be_successful

      market = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(market).to have_key(:id)
      expect(market[:id]).to eq(@market_1.id.to_s)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to eq(@market_1.name)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to eq(@market_1.street)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to eq(@market_1.city)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to eq(@market_1.county)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to eq(@market_1.state)

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to eq(@market_1.zip)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to eq(@market_1.lat)

      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to eq(@market_1.lon)

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to eq(4)
    end

    #Sad path
    it "responds with 404 status and descriptive error message when id passed in is invalid" do
      get "/api/v0/markets/4445482252529652"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=4445482252529652")
    end
  end

  describe "Market Search" do
    before do
      @market_1 = Market.create!(name: "Farmers Market", street: "1 Main Street", city: "San Francisco", county: "San Francisco", state: "California", zip: "94102", lat: "37.7955", lon: "122.3933")
      @market_2 = Market.create!(name: "Craft Market", street: "1 Broadway Avenue", city: "San Francisco", county: "San Francisco", state: "California", zip: "94102", lat: "37.8021", lon: "122.4487")
    end

    it "returns markets matching the search criteria" do
      get "/api/v0/markets/search?state=California"

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(markets.count).to eq(2)
      expect(markets).to be_an(Array)
    end
    # sad path
    it "responds with 422 status and descriptive error message when the search parameter passed in is invalid" do
      get "/api/v0/markets/search?city=San Francisco"

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end
  end
end
