# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  name       :string
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :integer
#

require 'rails_helper'

describe Song do
  
  subject(:song) { FactoryGirl.create(:song, name: "Foo") }

  it { should respond_to(:name) }
  it { should respond_to(:rank) }
  it { should respond_to(:album) }

  it { should be_valid }

  context "when name is not present" do
    before { song.name = nil }
    it { should_not be_valid }
  end

  # TODO refactor ranked and hot to shared examples
  
  describe "#hot" do
    
    context "when ranked in top 5" do
      before { song.rank = 5 }
      it { should be_hot }
    end

    context "when ranked below 5" do
      before { song.rank = 6 }
      it { should_not be_hot }
    end
  end

  describe ".ranked" do

    before do 
      FactoryGirl.create(:song, rank: 2)
      FactoryGirl.create(:song, rank: 1)
    end
    
    it "returns songs by rank" do
      expect(Song.ranked.first.rank).to be 1
      expect(Song.ranked.second.rank).to be 2
    end
  end  

  describe ".top(n)" do

    before do
      10.times { |i| FactoryGirl.create(:song, rank: i + 1) }
    end
    
    it "returns the top n songs" do
      expect(Song.top(2).first.rank).to be 1
      expect(Song.top(2).second.rank).to be 2
    end
  end

  describe ".hot" do

    before do 
      10.times { |i| FactoryGirl.create(:song, rank: i + 1) }
    end
    
    it "returns the top 5 songs" do
      expect(Song.hot.map(&:rank)).to eq [1,2,3,4,5]
    end
  end 
end
