require "rails_helper"

feature "home page - store finder" do
  include_context "features"

  scenario "user can see list of tacos and sauces", js: true do
    visit root_path
    random_taco  = Taco.all.sample
    random_salsa = Salsa.all.sample

    expect(page).to have_content(random_taco.name)
    expect(page).to have_content(random_salsa.name)
  end

  scenario "user can click tacos and sauces and see store results", js: true do
    visit root_path

    within(".taco-field") do
      check(taco_one.name)
      check(taco_three.name)
    end

    within(".salsa-field") do
      check(salsa_one.name)
      check(salsa_two.name)
    end

     expect(page).to have_content(store_one.name)
     expect(page).to_not have_content(store_two.name)
     expect(page).to_not have_content(store_three.name)
  end

  scenario "user can click tacos and sauces and see store results - no results found", js: true do
    visit root_path

    within(".taco-field") do
      check(taco_five.name)
    end

    within(".salsa-field") do
      check(salsa_five.name)
    end

    expect(page).to_not have_content(store_one.name)
    expect(page).to_not have_content(store_two.name)
    expect(page).to_not have_content(store_three.name)
  end
end