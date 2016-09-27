FactoryGirl.define do
  factory :car_wash do
    store_id { FactoryGirl.create(:store).id }
    hot_wax { [true, false].sample }
    full_detail { [true, false].sample }
  end
end