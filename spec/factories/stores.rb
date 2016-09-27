FactoryGirl.define do
  factory :store do
    name { Faker::Commerce.product_name }
    city_id { FactoryGirl.create(:city).id }
    sells_beer { [true, false].sample }
    zagat_rating { Array(1..10).sample }
  end
end