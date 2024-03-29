require 'rails_helper'

RSpec.describe Api::V1::TacosController, type: :controller do
  describe "GET /api/v1/tacos" do
    context "there are no tacos" do
      before(:each) do
        get :index, format: :json
      end

      it { should respond_with(200) }

      it "returns empty array if no there are no tacos" do
        expect(response_data.length).to eq(0)
        expect(response_data).to eq([])
      end
    end

    context "there are tacos" do
      before(:each) do
        @taco_one   = FactoryGirl.create(:taco)
        taco_two    = FactoryGirl.create(:taco)
        taco_three  = FactoryGirl.create(:taco)
        @taco_four  = FactoryGirl.create(:taco)
        get :index, format: :json
      end

      it { should respond_with(200) }

      it "returns all the tacos" do
        expect(response_data.length).to eq(4)
        expect(response_data[0][:name]).to eq(@taco_one.name)
        expect(response_data[3][:name]).to eq(@taco_four.name)
      end
    end
  end
end