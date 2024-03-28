require 'rails_helper'

RSpec.describe 'Nearest Atms API' do
  describe "happy path" do
    before do
      @market = Market.create!(name: "Farmers Market", street: "1 Main Street", city: "San Francisco", county: "San Francisco", state: "California", zip: "94102", lat: "37.7955", lon: "-122.3933")
    end

    it "returns JSON data of nearby ATMs", :vcr do
      get "/api/v0/markets/#{@market.id}/nearest_atms"
      expect(response).to be_successful

      atms = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(atms.count).to eq(10)
      expect(atms).to be_an(Array)
    end
  end

  describe 'Sad Path' do
    it "returns an error message if market id is invalid" do
      get "/api/v0/markets/4445482252529652/nearest_atms"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=4445482252529652")
    end
  end
end
