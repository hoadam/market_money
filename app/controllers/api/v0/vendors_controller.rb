class Api::V0::VendorsController < ApplicationController
  def show
    render json: Vendor.find(params[:id])
  end
end
