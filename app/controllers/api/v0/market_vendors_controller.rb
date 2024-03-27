class Api::V0::MarketVendorsController < ApplicationController
  def create
    vendor = Vendor.find(params[:vendor])
    market = Market.find(params[:market])
    market_vendor = MarketVendor.new(vendor_id: vendor.id.to_i, market_id: market.id.to_i)

    if market_vendor.save
      render json: "Vendor added to Market", status: 201
    else
      render json: { errors: market_vendor.errors.full_messages }, status: 400
    end
  end
end
