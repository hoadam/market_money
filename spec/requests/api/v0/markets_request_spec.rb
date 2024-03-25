require 'rails_helper'

describe "Markets Endpoints" do
  it "sends a list of all markets adding the vendor_count attribute to each market" do
    create_list(:market, 20)

    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body).map(&:symbolize_keys)

    expect(markets.count).to eq(20)
    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(Integer)

      expect(market).to have_key(:name)
      expect(market[:name]).to be_a(String)

      expect(market).to have_key(:street)
      expect(market[:street]).to be_a(String)

      expect(market).to have_key(:city)
      expect(market[:city]).to be_a(String)

      expect(market).to have_key(:county)
      expect(market[:county]).to be_a(String)

      expect(market).to have_key(:state)
      expect(market[:state]).to be_a(String)
      
      expect(market).to have_key(:zip)
      expect(market[:zip]).to be_a(String)

      expect(market).to have_key(:lat)
      expect(market[:lat]).to be_a(String)
      
      expect(market).to have_key(:lon)
      expect(market[:lon]).to be_a(String)

      expect(market).to have_key(:vendor_count)
      expect(market[:vendor_count]).to be_a(String)
    end
  end
end