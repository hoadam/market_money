require 'rails_helper'

RSpec.describe NearestAtmsSearchService do
  describe '#find_nearest_atms' do
    it 'returns an array of ATMs sorted by distance' do
      market = Market.create!(name: "Farmers Market", street: "1 Main Street", city: "San Francisco", county: "San Francisco", state: "California", zip: "94102", lat: "37.7955", lon: "-122.3933")

      lat = market.lat
      lon = market.lon

      VCR.use_cassette("nearby_atms") do
        atms = NearestAtmsSearchService.new.find_nearest_atms(lat,lon)

        expect(atms).to be_an(Array)
        expect(atms.first[:poi]).to have_key(:name)
        expect(atms.first[:address]).to have_key(:freeformAddress)
        expect(atms.first[:position]).to have_key(:lat)
        expect(atms.first[:position]).to have_key(:lon)
        expect(atms.first).to have_key(:dist)
        expect(atms).to eq(atms.sort_by {|atm| atm[:dist]})
      end
    end
  end
end
