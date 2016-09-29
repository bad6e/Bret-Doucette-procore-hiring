require 'rails_helper'

RSpec.describe Api::V1::SearchController, type: :controller do
  describe "GET /api/v1/search=" do

    context "no taco or salsa ids are submitted" do
      before(:each) do
        get :index, format: :json
      end

      it { should respond_with(400) }

      it "returns message error if no taco or salsa ids are submitted as params" do
        expect(response_data[:error]).to eq("Must provide taco and/or salsa ids")
      end
    end

    context "gibberish is submitted" do
      before(:each) do
        get :index, tacos: "!!#@}", salsas: "@@#{}", format: :json
      end

      it { should respond_with(200) }

      it "returns an empty array" do
        expect(response_data).to eq([])
      end
    end

    context "only tacos ids are submitted" do
      before(:each) do
        @store_one = FactoryGirl.create(:store)
        @store_two = FactoryGirl.create(:store)
        @taco_one  = FactoryGirl.create(:taco)
        @taco_two  = FactoryGirl.create(:taco)

        StoresTaco.create(store_id: @store_one.id, taco_id: @taco_one.id, price: BigDecimal.new('3.51'))
        StoresTaco.create(store_id: @store_two.id, taco_id: @taco_one.id, price: BigDecimal.new('3.52'))
        StoresTaco.create(store_id: @store_two.id, taco_id: @taco_two.id, price: BigDecimal.new('3.53'))
        searched_taco_ids = @taco_one.id.to_s + ',' + @taco_two.id.to_s
        get :index, tacos: searched_taco_ids, format: :json
      end

      it { should respond_with(200) }

      it "returns all the stores that have those two selected tacos" do
        expect(response_data.length).to eq(1)
        expect(response_data[0][:id]).to eq(@store_two.id)
      end
    end

    context "only salsa ids are submitted" do
      before(:each) do
        @store_one = FactoryGirl.create(:store)
        @store_two = FactoryGirl.create(:store)
        @salsa_one = FactoryGirl.create(:salsa)
        @salsa_two = FactoryGirl.create(:salsa)

        StoresSalsa.create(store_id: @store_one.id, salsa_id: @salsa_one.id, spiciness: 5)
        StoresSalsa.create(store_id: @store_two.id, salsa_id: @salsa_one.id, spiciness: 6)
        StoresSalsa.create(store_id: @store_two.id, salsa_id: @salsa_two.id, spiciness: 7)
        searched_salsa_ids = @salsa_one.id.to_s + ',' + @salsa_two.id.to_s
        get :index, salsas: searched_salsa_ids, format: :json
      end

      it { should respond_with(200) }

      it "returns all the stores that have those two selected salsas" do
        expect(response_data.length).to eq(1)
        expect(response_data[0][:id]).to eq(@store_two.id)
      end
    end

    context "both salsa and taco ids are submitted - results are found" do
      before(:each) do
        @store_one   = FactoryGirl.create(:store)
        @store_two   = FactoryGirl.create(:store)
        @salsa_one   = FactoryGirl.create(:salsa)
        @salsa_two   = FactoryGirl.create(:salsa)
        @taco_one    = FactoryGirl.create(:taco)
        @taco_two    = FactoryGirl.create(:taco)
        @taco_three  = FactoryGirl.create(:taco)

        StoresTaco.create(store_id: @store_one.id, taco_id: @taco_one.id, price: BigDecimal.new('3.51'))
        StoresTaco.create(store_id: @store_two.id, taco_id: @taco_one.id, price: BigDecimal.new('3.52'))
        StoresTaco.create(store_id: @store_two.id, taco_id: @taco_two.id, price: BigDecimal.new('3.53'))

        StoresSalsa.create(store_id: @store_one.id, salsa_id: @salsa_one.id, spiciness: 5)
        StoresSalsa.create(store_id: @store_two.id, salsa_id: @salsa_one.id, spiciness: 6)
        StoresSalsa.create(store_id: @store_two.id, salsa_id: @salsa_two.id, spiciness: 7)

        searched_taco_ids  = @taco_one.id.to_s + ',' + @taco_two.id.to_s
        searched_salsa_ids = @salsa_one.id.to_s + ',' + @salsa_two.id.to_s
        get :index, salsas: searched_salsa_ids, tacos: searched_taco_ids, format: :json
      end

      it { should respond_with(200) }

      it "returns all the stores that have those selected salsas AND tacos" do
        expect(response_data.length).to eq(1)
        expect(response_data[0][:id]).to eq(@store_two.id)
      end
    end

    context "both salsa and taco ids are submitted - no results are found" do
      before(:each) do
        get :index, tacos: "1", salsas: "1", format: :json
      end

      it "returns all no stores if there is not a match" do
        expect(response.code).to eq("200")
        expect(response_data.length).to eq(0)
      end
    end
  end
end