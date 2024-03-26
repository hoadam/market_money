require 'rails_helper'

describe "Vendors API" do
  describe "happy paths" do
    it "can get one book by its id" do
      id = create(:vendor).id

      get "/api/v0/vendors/#{id}"

      expect(response).to be_successful

      vendor = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
    end

    it "can create a new vendor" do
      vendor_params = ({
                        name: "Tony's Pizza",
                        description: "This vendor offers frozen pizza",
                        contact_name: "John Doe",
                        contact_phone: "123-456-7890",
                        credit_accepted: true
                      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      created_vendor = Vendor.last

      expect(response).to be_successful
      expect(created_vendor.name).to eq(vendor_params[:name])
      expect(created_vendor.description).to eq(vendor_params[:description])
      expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
      expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
      expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
    end
  end

  describe 'sad paths' do
    it "will gracefully handle if a vendor id doesn't exist" do
      get "/api/v0/vendors/123123123123"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end

    it "returns an error message if missing attributes" do
      vendor_params = ({
                        name: "Tony's Pizza",
                        description: "This vendor offers frozen pizza",
                        credit_accepted: true
                      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      created_vendor = Vendor.last

      expect(response).to_not be_successful
      expect(response.code).to eq("400")

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors]).to eq(["Contact name can't be blank", "Contact phone can't be blank"])
    end
  end
end
