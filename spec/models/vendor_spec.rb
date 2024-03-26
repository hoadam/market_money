require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe "Validations" do
    it {  should validate_presence_of :name }
    it {  should validate_presence_of :description  }
    it {  should validate_presence_of :contact_name }
    it {  should validate_presence_of :contact_phone  }
    it "validates presence of credit_accepted" do
      vendor = Vendor.new(name: 'AA', description: "abcd", contact_name: "John Doe", contact_phone: '123-45-7891')
      expect(vendor).not_to be_valid
      expect(vendor.errors[:credit_accepted]).to include("can't be nil")

      vendor.credit_accepted = false
      expect(vendor).to be_valid
    end
  end

  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:markets).through(:market_vendors) }
  end
end
