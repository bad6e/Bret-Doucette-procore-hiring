FactoryGirl.define do
  factory :salsa do
    name { Faker::StarWars.specie }
  end
end