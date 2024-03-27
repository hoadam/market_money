class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor)
    else
      render json: { errors: vendor.errors.full_messages }, status: 400
    end
  end

  def update
    vendor = Vendor.find(params[:id])

    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor)
    else
      render json: { errors: vendor.errors.full_messages }, status: 400
    end
  end

  def index
    market = Market.find(params[:market_id])

    if market != nil
      render json: VendorSerializer.new(market.vendors)
    else
      render json: { errors: market.errors.full_messages }, status: 400
    end
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.destroy

    render json: VendorSerializer.new(vendor)
  end

  private

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end
