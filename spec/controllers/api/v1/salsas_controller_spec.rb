require 'rails_helper'

RSpec.describe Api::V1::SalsasController, type: :controller do
   describe "GET /api/v1/salsas" do
    context "there are no salsas" do
      before(:each) do
        get :index, format: :json
      end

      it { should respond_with(200) }

      it "returns empty array if there are no salsas/sauces" do
        expect(response_data.length).to eq(0)
        expect(response_data).to eq([])
      end
    end

    context "there are tacos" do
      before(:each) do
        @salsa_one   = FactoryGirl.create(:salsa)
        salsa_two   = FactoryGirl.create(:salsa)
        salsa_three = FactoryGirl.create(:salsa)
        @salsa_four  = FactoryGirl.create(:salsa)
        get :index, format: :json
      end

      it { should respond_with(200) }

      it "returns all the salsas/sauces" do
        expect(response_data.length).to eq(4)
        expect(response_data[0][:name]).to eq(@salsa_one.name)
        expect(response_data[3][:name]).to eq(@salsa_four.name)
      end
    end
  end
end