class MarketSerializer
  include JSONAPI::Serializer
  attributes :id,
             :name, 
             :street, 
             :city, 
             :county, 
             :state, 
             :zip, 
             :lat, 
             :lon, 
             :vendor_count

  def self.format_market_data(market)
    {
      id: market.id,
      type: "market",
      attributes: market_attributes(market)
    }
  end

  def self.format_markets(markets)
    {
      data: markets.map { |market| format_market_data(market) }
    }
  end

  private

  def self.market_attributes(market)
    {
      name: market.name,
      street: market.street,
      city: market.city,
      county: market.county,
      state: market.state,
      zip: market.zip,
      lat: market.lat,
      lon: market.lon,
      vendor_count: market.vendor_count
    }
  end
end
