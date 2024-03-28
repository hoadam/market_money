class NearestAtmsSerializer
  include JSONAPI::Serializer

  attributes :name, :address, :lat, :lon, :distance

  def self.format_atms(atms)
    {
      data: atms.map do|atm|
        {
          id: nil,
          type: "atm",
          attributes: {
            name: "ATM",
            address: atm[:address][:freeformAddress],
            lat: atm[:position][:lat],
            lon: atm[:position][:lon],
            distance: atm[:dist]
          }
        }
      end
    }
  end
end
