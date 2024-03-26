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

  def self.format_markets(markets)
    {
      data: markets.map do |market|
        {
          id: market.id,
          attributes: {
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
        }
      end
    }
  end
end