class Api::V0::NearestAtmsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    market = Market.find(params[:market_id])

    if market != nil
      nearest_atms_service = NearestAtmsSearchService.new
      atms = nearest_atms_service.find_nearest_atms(market.lat, market.lon)

      render json: NearestAtmsSerializer.format_atms(atms)
    end
  end

  private

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

end
