require 'rails_helper'

require 'rails_helper'

RSpec.describe Market, type: :model do
  describe "Validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :county}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :lat}
    it {should validate_presence_of :lon}
  end

  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'instance methods' do
    before do
      @market_1 = create(:market)
      
      @vendor_1 = create(:vendor)
      @vendor_2 = create(:vendor)
      @vendor_3 = create(:vendor)
      @vendor_4 = create(:vendor)
      @vendor_5 = create(:vendor)

      @vm_1_1 = @market_1.market_vendors.create(vendor: @vendor_1)
      @vm_1_2 = @market_1.market_vendors.create(vendor: @vendor_2)
      @vm_1_3 = @market_1.market_vendors.create(vendor: @vendor_3)
      @vm_1_4 = @market_1.market_vendors.create(vendor: @vendor_4)
    end

    describe 'vendor_count' do
      it 'returns the number of vendors that are associated with that market.' do
        expect(@market_1.vendor_count).to eq(4)
      end
    end
  end
end