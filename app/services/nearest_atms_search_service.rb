class NearestAtmsSearchService
  def find_nearest_atms(lat,lon)
    conn = Faraday.new(url: "https://api.tomtom.com")

    response = conn.get("/search/2/nearbySearch/.json?lat=#{lat}&lon=#{lon}&categorySet=7397&view=Unified&relatedPois=off&key=4QlfGltxA6YAiZ5C6oNyTRvCcWGjJ4yZ")
    data = JSON.parse(response.body, symbolize_names: true)

    data[:results]
  end
end
