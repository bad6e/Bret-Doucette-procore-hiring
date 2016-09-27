require 'rails_helper'

describe Salsa do
  subject { create(:salsa) }

  it { should be_valid }

  it { should respond_to(:name) }

  it { should validate_presence_of(:name) }

  it { should have_many (:stores)}
  it { should have_many (:stores_salsas)}

  it do
    should validate_length_of(:name).
      is_at_most(255)
  end
end