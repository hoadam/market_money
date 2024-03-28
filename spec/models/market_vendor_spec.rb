require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  before do
    @market_1 = create(:market)
    @market_2 = create(:market)
    @vendor_1 = create(:vendor)
    @vendor_2 = create(:vendor)
    @new_market_vendor = MarketVendor.new(market: @market_1,vendor: @vendor_1)
  end

  describe 'relationships' do
    it { should belong_to :market }
    it { should belong_to :vendor }
  end

  describe 'validations' do
    describe 'valid_assoc' do
      it 'does not add an error when market vendor association does not already exist' do
        
        expect(@new_market_vendor.valid?).to be_truthy
        expect(@new_market_vendor.errors).to be_empty
      end

      it 'adds an error for invalid market' do
        @new_market_vendor.market_id = nil
        @new_market_vendor.valid?

        expect(@new_market_vendor.errors[:market_id]).to include("can't be blank")
      end

      it 'adds an error for invalid vendor' do
        @new_market_vendor.vendor_id = nil
        @new_market_vendor.valid?
        
        expect(@new_market_vendor.errors[:vendor_id]).to include("can't be blank")
      end
    end
  end
end