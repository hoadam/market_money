class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validate :valid_assoc, on: :create

  def valid_assoc
    return unless market && vendor
    
    existing_association = MarketVendor.find_by(vendor_id: vendor.id, market_id: market.id)

    errors.add(:base, 'Association already exists') if existing_association.present?
  end
end