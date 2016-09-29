require 'rails_helper'

describe City do
  subject { create(:stores_salsa) }

  it { should be_valid }

  it { should respond_to(:store_id) }
  it { should respond_to(:salsa_id) }

  it { should validate_presence_of(:store_id) }
  it { should validate_presence_of(:salsa_id) }
  it { should validate_presence_of(:spiciness) }

  it { should validate_uniqueness_of(:salsa_id).scoped_to(:store_id) }

  it { should belong_to(:store) }
  it { should belong_to(:salsa) }

  it { should validate_numericality_of(:spiciness).only_integer }
end