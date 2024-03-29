class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  before_action :validate_parameters

  def create
    vendor = Vendor.find(params[:vendor_id])
    market = Market.find(params[:market_id])

    market_vendor = MarketVendor.new(vendor_id: vendor.id, market_id: market.id)

    if market_vendor.save
      render_success('Vendor added to Market', 201)
    else
      render_error("Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists", 422)
    end
  end

  def destroy
    market_vendor = MarketVendor.find_by(vendor_id: params[:vendor_id], market_id: params[:market_id])

     if market_vendor
      if market_vendor.destroy
        render_success('', 204)
      end
    else
      render_error("No MarketVendor with market_id=#{params[:market_id]} AND vendor_id=#{params[:vendor_id]} exists", 404)
    end
  end

  private
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end

  def validate_parameters
    unless params[:market_id].present? && params[:vendor_id].present?
      render_error('Both market_id and vendor_id are required', 400)
    end
  end

  def render_error(message, status)
    render json: { errors: [{detail: message }] }, status: status
  end

  def render_success(message, status)
    render json: { message: message }, status: status
  end
end
