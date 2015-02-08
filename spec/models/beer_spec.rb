require 'rails_helper'

describe Beer, type: :model do
  it "is not saved without a name" do
    beer = Beer.create name:nil, style:"kura"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a name" do
    beer = Beer.create name:"Koff"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "with name and style set is saved" do
    beer = Beer.create name:"Koff", style:"kura"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

end