require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) {FactoryGirl.create :user, username: "Simo" }
  let!(:rating) { FactoryGirl.create :rating, user:user, beer:beer1}
  let!(:rating2) { FactoryGirl.create :rating2, user:user2, beer:beer2}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "count and result is shown in rating index" do
    visit ratings_path
    expect(page).to have_content("Number of ratings: 2")

    expect(page).to have_content("iso 3 10")
    expect(page).to have_content("Karhu 20")

  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(2).to(3)

    expect(user.ratings.count).to eq(2)
    expect(beer1.ratings.count).to eq(2)
    expect(beer1.average_rating).to eq(12.5)
  end

  describe "given ratings" do

    before :each do
      visit user_path(user)
    end

    it "are shown on a user's page" do
      expect(page).to have_content("iso 3 10")
      expect(page).not_to have_content("Karhu 20")
    end

    it "are properly removed from user's page and database" do
      expect{
        click_link "delete"
      }.to change{Rating.count}.from(2).to(1)

      expect(page).not_to have_content("iso 3 10")

    end
  end
end