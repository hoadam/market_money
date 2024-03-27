class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validate :valid_assoc, on: :create

  def valid_assoc
    errors.add(:market_id, "can't be blank") unless market_id.present?
    errors.add(:vendor_id, "can't be blank") unless vendor_id.present?

    if market_id.present? && vendor_id.present?
      existing_association = MarketVendor.find_by(vendor_id: vendor_id, market_id: market_id)
      errors.add(:base, 'Association already exists') if existing_association
    end
  end
end