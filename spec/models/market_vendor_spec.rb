require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  before do
    @market_1 = create(:market)
    @market_2 = create(:market)
    @vendor_1 = create(:vendor)
    @vendor_2 = create(:vendor)
  end

  describe 'relationships' do
    it { should belong_to :market }
    it { should belong_to :vendor }
  end

  describe 'instance_variables' do
    describe 'valid_assoc' do
      it 'is false when market vendor already exists' do

        @existing_association = MarketVendor.create(market: @market_1,vendor: @vendor_1)
      
        @new_market_vendor = MarketVendor.new(market: @market_1,vendor: @vendor_1)

        @new_market_vendor.valid_assoc
      
        expect(@new_market_vendor.errors[:base]).to include("Association already exists")
      end
    end
  end
end