FactoryGirl.define do
  factory :city do
    name { Faker::Address.city }
    allows_drones { [true, false].sample }
  end
end