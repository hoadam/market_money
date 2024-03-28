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
      render_error("Validation failed: Market vendor asociation between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists", 422)
    end
  end

  def destroy
    market_id = params[:market_id].to_i
    vendor_id = params[:vendor_id].to_i
    
    unless vendor_id.present? && market_id.present?
      render_error('Both market_id and vendor_id are required', 400)
      return
    end
  
    market_vendor = MarketVendor.find_by(vendor_id: vendor_id, market_id: market_id)
  
    unless market_vendor
      render_error("No MarketVendor with market_id=#{market_id} AND vendor_id=#{vendor_id} exists", 404)
      return
    end
  
    if market_vendor.destroy
      render_success('', 204)
    else
      render_error('Failed to destroy MarketVendor', 500)
    end
  end

  private
  def render_error(message, status)
    render json: { errors: message }, status: status
  end

  def render_success(message, status)
    render json: { message: message }, status: status
  end
end
