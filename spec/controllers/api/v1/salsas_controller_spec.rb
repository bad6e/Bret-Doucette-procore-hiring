require 'rails_helper'

RSpec.describe Api::V1::SalsasController, type: :controller do
   describe "GET /api/v1/interests" do

    it "returns empty array if no Salsas/Sauces" do
      get :index, format: :json
      expect(response_data.length).to eq(0)
      expect(response_data).to eq([])
    end

    it "returns all the Salsas/Sauces" do
      salsa_one   = FactoryGirl.create(:salsa)
      salsa_two   = FactoryGirl.create(:salsa)
      salsa_three = FactoryGirl.create(:salsa)
      salsa_four  = FactoryGirl.create(:salsa)

      get :index, format: :json
      expect(response_data.length).to eq(4)
      expect(response_data[0][:name]).to eq(salsa_one.name)
    end
  end
end