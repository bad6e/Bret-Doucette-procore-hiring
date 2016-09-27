FactoryGirl.define do
  factory :taco do
    name { Faker::StarWars.specie }
    vegetarian { [true, false].sample }
  end
end