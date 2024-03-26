require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe "Validations" do

  end

  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:markets).through(:market_vendors) }
  end
end