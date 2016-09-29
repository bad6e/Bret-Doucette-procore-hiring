require 'rails_helper'

describe CarWash do
  subject { create(:car_wash) }

  it { should be_valid }

  it { should respond_to(:store_id) }
  it { should respond_to(:hot_wax) }
  it { should respond_to(:full_detail) }

  it { should validate_presence_of(:store_id) }

  it { should validate_uniqueness_of(:store_id) }

  it { should belong_to(:store) }

  it do
    should have_db_column(:hot_wax).of_type(:boolean)
    should have_db_column(:full_detail).of_type(:boolean)
  end
end