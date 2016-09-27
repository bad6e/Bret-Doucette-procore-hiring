require 'rails_helper'

describe City do
  subject { create(:city) }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:allows_drones) }

  it { should validate_presence_of(:name) }

  it { should have_many (:stores)}

  it do
    should validate_length_of(:name).
      is_at_most(255)
  end

  it do
    should have_db_column(:allows_drones).of_type(:boolean)
  end
end