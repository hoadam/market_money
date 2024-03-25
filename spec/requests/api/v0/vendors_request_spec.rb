require 'rails_helper'

describe "Vendors API" do
  it "sends a list of vendors" do
    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor = JSON.parse(response.body, symbolize_names: true)

    expect(vendor).to have_key(:id)
    expect(vendor[:id]).to eq(id)

    expect(vendor).to have_key(:name)
    expect(vendor[:name]).to be_a(String)

    expect(vendor).to have_key(:description)
    expect(vendor[:description]).to be_a(String)

    expect(vendor).to have_key(:contact_name)
    expect(vendor[:contact_name]).to be_a(String)

    expect(vendor).to have_key(:contact_phone)
    expect(vendor[:contact_phone]).to be_a(String)

    expect(vendor).to have_key(:credit_accepted)
    expect(vendor[:credit_accepted]).to be_in([true, false])
  end
end
