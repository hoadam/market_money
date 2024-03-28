class Api::V0::MarketVendorsController < ApplicationController
  def create
    market_id = params[:market_id]
    vendor_id = params[:vendor_id]

    unless market_id.present? && vendor_id.present?
      render_error('Both market_id and vendor_id are required', 400)
      return
    end

    vendor = Vendor.find(params[:vendor_id])
    market = Market.find(params[:market_id])

    unless vendor && market
      render_error('Vendor or Market not found', 404)
      return
    end

    market_vendor = MarketVendor.new(vendor_id: vendor.id.to_i, market_id: market.id.to_i) 

    if market_vendor.save
      render_success('Vendor added to Market', 201)
    else
      render json: { errors: market_vendor.errors.full_messages }, status: 400
    end
  end

  private
  def render_error(message, status)
    render json: { error: message }, status: status
  end

  def render_success(message, status)
    render json: { message: message }, status: status
  end
end
