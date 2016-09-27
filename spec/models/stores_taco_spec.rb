require 'rails_helper'

describe City do
  subject { create(:stores_taco) }

  it { should be_valid }

  it { should respond_to(:store_id) }
  it { should respond_to(:taco_id) }

  it { should validate_presence_of(:store_id) }
  it { should validate_presence_of(:taco_id) }
  it { should validate_presence_of(:price) }

  it { should belong_to(:store) }
  it { should belong_to(:taco) }

  it { should validate_numericality_of(:price) }
end