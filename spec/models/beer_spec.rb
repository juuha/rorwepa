require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with a proper brewery" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 } 
    
    it "is saved" do
      beer = Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery
    
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not saved without a name" do
      beer = Beer.create name: "", style: "teststyle", brewery: test_brewery
    
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = Beer.create name: "testbeer", style: "" , brewery: test_brewery
    
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
