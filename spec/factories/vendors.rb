FactoryBot.define do
  factory :vendor do
    name { Faker::Vendor.name }
    description { Faker::Lorem.paragraph }
    contact_name { Faker::Vendor.name }
    contact_phone { Faker::Vendor.phone_number }
    credit_accepted { Faker::Boolean.boolean }
  end
end