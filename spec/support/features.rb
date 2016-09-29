shared_context "features" do
  let!(:taco_one) {
    FactoryGirl.create(:taco, name: 'taco_one')
  }

  let!(:taco_two) {
    FactoryGirl.create(:taco, name: 'taco_two')
  }

  let!(:taco_three) {
    FactoryGirl.create(:taco, name: 'taco_three')
  }

  let!(:taco_four) {
    FactoryGirl.create(:taco, name: 'taco_four')
  }

  let!(:taco_five) {
    FactoryGirl.create(:taco, name: 'taco_five')
  }

  let!(:salsa_one) {
    FactoryGirl.create(:salsa, name: 'salsa_one')
  }

  let!(:salsa_two) {
    FactoryGirl.create(:salsa, name: 'salsa_two')
  }

  let!(:salsa_three) {
    FactoryGirl.create(:salsa, name: 'salsa_three')
  }

  let!(:salsa_four) {
    FactoryGirl.create(:salsa, name: 'salsa_four')
  }

  let!(:salsa_five) {
    FactoryGirl.create(:salsa, name: 'salsa_five')
  }

  let!(:store_one) {
    FactoryGirl.create(:store)
  }

  let!(:store_two) {
    FactoryGirl.create(:store)
  }

  let!(:store_three) {
    FactoryGirl.create(:store)
  }

  let!(:stores_taco_one) {
    StoresTaco.create(store_id: store_one.id,
                      taco_id: taco_one.id,
                      price: BigDecimal.new('3.51')
                     )
  }

  let!(:stores_taco_two) {
    StoresTaco.create(store_id: store_two.id,
                      taco_id: taco_one.id,
                      price: BigDecimal.new('3.52')
                     )
  }

  let!(:stores_taco_three) {
    StoresTaco.create(store_id: store_one.id,
                      taco_id: taco_three.id,
                      price: BigDecimal.new('3.53')
                     )
  }

  let!(:stores_salsa_one) {
   StoresSalsa.create(store_id: store_one.id,
                      salsa_id: salsa_one.id,
                      spiciness: 5
                     )
  }

  let!(:stores_salsa_two) {
    StoresSalsa.create(store_id: store_one.id,
                       salsa_id: salsa_two.id,
                       spiciness: 6
                       )
  }

  let!(:stores_salsa_three) {
    StoresSalsa.create(store_id: store_two.id,
                       salsa_id: salsa_two.id,
                       spiciness: 7
                      )
  }
end