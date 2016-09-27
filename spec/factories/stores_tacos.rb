FactoryGirl.define do
  factory :stores_taco do
    store_id { FactoryGirl.create(:store).id }
    taco_id { FactoryGirl.create(:taco).id }
    price { BigDecimal.new('3.51') }
  end
end