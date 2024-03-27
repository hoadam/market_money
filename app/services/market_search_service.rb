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
  end

  def search
    search_filter =
      if (state_present && city_present && name_present)
        { state: search_params[:state], city: search_params[:city], name: search_params[:name]  }
      elsif (state_present && name_present)
        { state: search_params[:state], name: search_params[:name]  }
      elsif (state_present && city_present)
        { state: search_params[:state], name: search_params[:city]  }
      elsif state_present
        { state: search_params[:state]  }
      elsif name_present
        { name: search_params[:name]  }
      end

    Market.where(search_filter)
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
