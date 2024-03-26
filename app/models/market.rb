class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  validates_presence_of :name,
                        :street,
                        :city,
                        :county,
                        :state,
                        :zip,
                        :lat,
                        :lon

  def vendor_count
    vendors.count
  end

  def as_json(options = {})
    super(options.merge(methods: :vendor_count))
  end
end
