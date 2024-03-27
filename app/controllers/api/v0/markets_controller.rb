class Api::V0::MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end

  def search
    search_service = MarketSearchService.new(params)
    if search_service.valid?
      render json: MarketSerializer.new(search_service.search)

    else
      render json: { errors: [{ detail: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."}  ] }, status: 422
    end
  end

  private

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end
end
