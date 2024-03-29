class NearestAtmsSearchService
  def find_nearest_atms(lat,lon)
    conn = Faraday.new(url: "https://api.tomtom.com")

    response = conn.get(
      "/search/2/nearbySearch/.json",
      {
        key: Rails.application.credentials[:tomtom_api_key],
        lat: lat,
        lon: lon,
        categorySet: 7397
      }
    )
    data = JSON.parse(response.body, symbolize_names: true)

    data[:results]
  end
end
