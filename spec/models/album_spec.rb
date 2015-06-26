# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  name        :string
#  released_at :date
#  artist_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rank        :integer
#

require 'rails_helper'

describe Album do

  subject(:album) do
    FactoryGirl.create(:album, name: "Foo", released_at: "2008-01-27")
  end

  it { should respond_to(:name) }
  it { should respond_to(:released_at) }
  it { should respond_to(:rank) }  
  it { should respond_to(:artist_id) }
  it { should respond_to(:artist) }
  it { should respond_to(:songs) }

  it { should be_valid }

  context "when name is not present" do
    before { album.name = nil }
    it { should_not be_valid }
  end

  # TODO refactor ranked and hot to shared examples
  
  describe "#hot" do
    
    context "when ranked in top 5" do
      before { album.rank = 5 }
      it { should be_hot }
    end

    context "when ranked below 5" do
      before { album.rank = 6 }
      it { should_not be_hot }
    end
  end  

  describe ".recent_releases" do

    it "includes albums released within a month" do
      album = FactoryGirl.create(:album, released_at: 7.days.ago)
      expect(Album.recent_releases).to include album
    end

    it "excludes albums released more than a month ago" do
      album = FactoryGirl.create(:album, released_at: 2.months.ago)
      expect(Album.recent_releases).to_not include album
    end
  end

  describe ".ranked" do

    before do 
      FactoryGirl.create(:album, rank: 2)
      FactoryGirl.create(:album, rank: 1)
    end
    
    it "returns albums by rank" do
      expect(Album.ranked.first.rank).to be 1
      expect(Album.ranked.second.rank).to be 2
    end
  end  

  describe ".top(n)" do

    before do 
      10.times { |i| FactoryGirl.create(:album, rank: i + 1) }
    end
    
    it "returns the top n albums" do
      expect(Album.top(2).first.rank).to be 1
      expect(Album.top(2).second.rank).to be 2
    end
  end

  describe ".hot" do

    before do 
      10.times { |i| FactoryGirl.create(:album, rank: i + 1) }
    end
    
    it "returns the top 5 albums" do
      expect(Album.hot.map(&:rank)).to eq [1,2,3,4,5]
    end
  end  
end
