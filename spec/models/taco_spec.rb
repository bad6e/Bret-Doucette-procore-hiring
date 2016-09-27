require 'rails_helper'

describe Taco do
  subject { create(:taco) }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:vegetarian) }

  it { should validate_presence_of(:name) }

  it { should have_many (:stores)}
  it { should have_many (:stores_tacos)}

  it do
    should validate_length_of(:name).
      is_at_most(255)
  end

  it do
    should have_db_column(:vegetarian).of_type(:boolean)
  end
end