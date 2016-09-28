require 'rails_helper'

describe Store do
  subject { create(:store) }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:city_id) }
  it { should respond_to(:sells_beer) }
  it { should respond_to(:zagat_rating) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:city_id) }
  it { should validate_presence_of(:zagat_rating) }

  it { should have_one (:car_wash)}

  it { should belong_to(:city) }

  it { should have_many (:tacos)}
  it { should have_many (:stores_tacos)}

  it { should have_many (:salsas)}
  it { should have_many (:stores_salsas)}

  it { should validate_numericality_of(:zagat_rating).only_integer }

  it do
    should validate_length_of(:name).
      is_at_most(255)
  end

  it do
    should have_db_column(:sells_beer).of_type(:boolean)
  end

  it "should find stores with specific tacos by taking the taco_ids" do
    store_one = FactoryGirl.create(:store)
    store_two = FactoryGirl.create(:store)
    taco_one  = FactoryGirl.create(:taco)
    taco_two  = FactoryGirl.create(:taco)

    StoresTaco.create(store_id: store_one.id, taco_id: taco_one.id, price: BigDecimal.new('3.51'))
    StoresTaco.create(store_id: store_two.id, taco_id: taco_one.id, price: BigDecimal.new('3.52'))
    StoresTaco.create(store_id: store_two.id, taco_id: taco_two.id, price: BigDecimal.new('3.53'))

    found_stores = Store.find_all_stores_with_specific_tacos([taco_two.id.to_s], 1)
    expect(found_stores.length).to eq(1)
    expect(found_stores[0][:name]).to eq(store_two.name)
  end

  it "should find stores with specific salsas by taking the salsa_ids" do
    store_one = FactoryGirl.create(:store)
    store_two = FactoryGirl.create(:store)
    salsa_one  = FactoryGirl.create(:salsa)
    salsa_two  = FactoryGirl.create(:salsa)

    StoresSalsa.create(store_id: store_one.id, salsa_id: salsa_one.id, spiciness: 1)
    StoresSalsa.create(store_id: store_two.id, salsa_id: salsa_one.id, spiciness: 2)
    StoresSalsa.create(store_id: store_two.id, salsa_id: salsa_two.id, spiciness: 3)

    found_stores = Store.find_all_stores_with_specific_salsas([salsa_two.id.to_s], 1)
    expect(found_stores.length).to eq(1)
    expect(found_stores[0][:name]).to eq(store_two.name)
  end
end