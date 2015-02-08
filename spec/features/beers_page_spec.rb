require 'rails_helper'

describe "Beers page" do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "should not have any before been created" do
    visit beers_path
    expect(page).to have_content 'Listing beers'

  end

  it "doesn't allow beers with blank names" do
    visit new_beer_path
    click_button('Create Beer')

    expect(page).to have_content("Name can't be blank")
    expect(Beer.count).to eq(0)
  end

  it "allows beers to be created" do
    visit new_beer_path
    fill_in('beer_name', with: 'Brixton')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

end