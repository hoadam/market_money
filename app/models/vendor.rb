class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates_presence_of :name,
                        :description,
                        :contact_name,
                        :contact_phone
  validate :credit_accepted_presence

  def credit_accepted_presence
    errors.add(:credit_accepted, "can't be nil")if credit_accepted.nil?
  end
end
