FactoryGirl.define do
  factory :stores_salsa do
    salsa_id { FactoryGirl.create(:salsa).id }
    store_id { FactoryGirl.create(:store).id }
    spiciness { Array(1..10).sample }
  end
end