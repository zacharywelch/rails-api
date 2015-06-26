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
  it { should respond_to(:rank) }
  it { should respond_to(:albums) }
  it { should respond_to(:songs) }

  it { should be_valid }
  it { should_not be_featured }

  # TODO refactor ranked and hot to shared examples
  
  describe "#hot" do
    
    context "when ranked in top 5" do
      before { artist.rank = 5 }
      it { should be_hot }
    end

    context "when ranked below 5" do
      before { artist.rank = 6 }
      it { should_not be_hot }
    end
  end  

  context "when name is not present" do
    before { artist.name = nil }
    it { should_not be_valid }
  end

  describe ".featured" do

    it "includes featured artists" do
      artist = FactoryGirl.create(:artist, featured: true)
      expect(Artist.featured).to include artist
    end

    it "excludes artists not featured" do
      artist = FactoryGirl.create(:artist)
      expect(Artist.featured).to_not include artist
    end
  end

  describe ".ranked" do

    before do 
      FactoryGirl.create(:artist, rank: 2)
      FactoryGirl.create(:artist, rank: 1)
    end
    
    it "returns albums by rank" do
      expect(Artist.ranked.first.rank).to be 1
      expect(Artist.ranked.second.rank).to be 2
    end
  end  

  describe ".top(n)" do

    before do 
      10.times { |i| FactoryGirl.create(:artist, rank: i + 1) }
    end
    
    it "returns the top n albums" do
      expect(Artist.top(2).first.rank).to be 1
      expect(Artist.top(2).second.rank).to be 2
    end
  end

  describe ".hot" do

    before do 
      10.times { |i| FactoryGirl.create(:artist, rank: i + 1) }
    end
    
    it "returns the top 5 albums" do
      expect(Artist.hot.map(&:rank)).to eq [1,2,3,4,5]
    end
  end   
end
