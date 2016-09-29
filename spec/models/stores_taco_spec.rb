require 'rails_helper'

describe City do
  subject { create(:stores_taco) }

  it { should be_valid }

  it { should respond_to(:store_id) }
  it { should respond_to(:taco_id) }

  it { should validate_presence_of(:store_id) }
  it { should validate_presence_of(:taco_id) }
  it { should validate_presence_of(:price) }

  it { should validate_uniqueness_of(:taco_id).scoped_to(:store_id) }

  it { should belong_to(:store) }
  it { should belong_to(:taco) }

  it { should validate_numericality_of(:price) }

  it "should only accept prices in the X.XX format - rounds down" do
    stores_taco = FactoryGirl.create(:stores_taco, price: BigDecimal.new('3.51'))
    expect(stores_taco.price).to eq(BigDecimal.new('3.51'))
  end

  it "should only accept prices in the X.XX format - rounds up" do
    stores_taco = FactoryGirl.create(:stores_taco, price: BigDecimal.new('3.519'))
    expect(stores_taco.price).to eq(BigDecimal.new('3.52'))
  end
end