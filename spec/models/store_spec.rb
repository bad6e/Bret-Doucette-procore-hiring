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
end