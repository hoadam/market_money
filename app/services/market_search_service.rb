class MarketSearchService
  attr_reader :search_params

  def initialize(search_params)
    @search_params = search_params

  end

  def valid?
    return true if (state_present && city_present && name_present)
    return true if (state_present && name_present) || (state_present && city_present)
    return false if (city_present && name_present)
    return false if city_present
    return true if state_present || name_present

    false
  end

  def search
      query = Market
      query = query.where(state: search_params[:state]) if state_present
      query = query.where(city: search_params[:city]) if city_present
      query = query.where("name ILIKE ?", "%#{search_params[:name]}%") if name_present
      query.all
  end

  private

  def state_present
    search_params[:state].present?
  end

  def city_present
    search_params[:city].present?
  end

  def name_present
    search_params[:name].present?
  end
end
