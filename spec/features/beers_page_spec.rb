require 'rails_helper'

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }

  it "is saved when given proper name" do
    visit new_beer_path
    fill_in('beer[name]', with:'Karhu')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button("Create Beer")
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is not saved when given an invalid name" do
    visit new_beer_path
    fill_in('beer[name]', with:'')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button("Create Beer")
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name is too short"
  end
end
