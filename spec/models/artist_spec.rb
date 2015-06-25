# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  featured   :boolean          default("f")
#  rank       :integer
#

require 'rails_helper'

describe Artist do
  
  subject(:artist) { FactoryGirl.create(:artist, name: "Foo") }

  it { should respond_to(:name) }
  it { should respond_to(:albums) }
  it { should respond_to(:songs) }
  it { should respond_to(:rank) }

  it { should be_valid }
  it { should_not be_featured }

  context "when name is not present" do
    before { artist.name = nil }
    it { should_not be_valid }
  end

  describe "#featured" do

    it "includes featured artists" do
      artist = FactoryGirl.create(:artist, featured: true)
      expect(Artist.featured).to include artist
    end

    it "excludes artists not featured" do
      artist = FactoryGirl.create(:artist)
      expect(Artist.featured).to_not include artist
    end
  end

  describe "#ranked" do

    before do 
      FactoryGirl.create(:artist, rank: 2)
      FactoryGirl.create(:artist, rank: 1)
    end
    
    it "returns artists by rank" do
      expect(Artist.ranked.first.rank).to be 1
      expect(Artist.ranked.second.rank).to be 2
    end
  end  

  describe "#top(n)" do

    before do 
      10.times { |i| FactoryGirl.create(:artist, rank: i + 1) }
    end
    
    it "returns the top n artists" do
      expect(Artist.top(2).first.rank).to be 1
      expect(Artist.top(2).second.rank).to be 2
    end
  end  
end
