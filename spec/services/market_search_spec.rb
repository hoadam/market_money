require 'rails_helper'

RSpec.describe MarketSearchService do
  describe '#valid?' do
    it "returns true if valid parameters, including state, city and name, are present" do
      market_search = MarketSearchService.new(state: 'California', city: 'San Francisco', name: 'Farmers Market')
      expect(market_search.valid?).to eq(true)
    end

    it "returns true if valid parameters, including state and city, are present" do
      market_search = MarketSearchService.new(state: 'California', city: 'San Francisco')
      expect(market_search.valid?).to eq(true)
    end

    it "returns true if valid parameters, including state and name, are present" do
      market_search = MarketSearchService.new(state: 'California', name: 'Farmers Market')
      expect(market_search.valid?).to eq(true)
    end

    it "returns true if valid state parameter is present" do
      market_search = MarketSearchService.new(state: 'California')
      expect(market_search.valid?).to eq(true)
    end

    it "returns true if valid name parameter is present" do
      market_search = MarketSearchService.new(name: 'Farmers Market')
      expect(market_search.valid?).to eq(true)
    end

    it "returns false if parameter has only city parameter" do
      market_search = MarketSearchService.new(city: 'San Francisco')
      expect(market_search.valid?).to eq(false)
    end

    it "returns false if invalid combination of city and name parameters is present" do
      market_search = MarketSearchService.new(city: 'San Francisco', name: "Farmers Market")
      expect(market_search.valid?).to eq(false)
    end
  end

  describe "#search" do
    it "returns markets matching the search parameters" do
      market_1 = Market.create!(name: "Farmers Market", street: "1 Main Street", city: "San Francisco", county: "San Francisco", state: "California", zip: "94102", lat: "37.7955", lon: "122.3933")
      market_2 = Market.create!(name: "Craft Market", street: "1 Broadway Avenue", city: "San Francisco", county: "San Francisco", state: "California", zip: "94102", lat: "37.8021", lon: "122.4487")

      market_search = MarketSearchService.new(state: "California")

      expect(market_search.search).to eq([market_1, market_2])
    end
  end

end
