FactoryBot.define do
  factory :market do
    name { Faker::Commerce.vendor }
    street { Faker::Adress.street_address }
    city { Faker::Address.city }
    county { Faker::Adress.county }
    state { Faker::Adress.state }
    zip { Faker::Adress.zip }
    lat { Faker::Adress.latitude }
    lon { Faker::Adress.longitude }
  end
end