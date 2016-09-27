FactoryGirl.define do
  factory :stores_salsa do
    salsa_id { 1 }
    store_id { 2 }
    spiciness { Array(1..10).sample }
  end
end