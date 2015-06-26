require 'rails_helper'

RSpec.shared_examples "ranked" do

  let(:factory) { described_class.name.underscore.to_sym }

  describe ".ranked" do
    
    before do
      FactoryGirl.create(factory, rank: 2)
      FactoryGirl.create(factory, rank: 1)
    end
    
    it "returns #{described_class.model_name.plural} by rank" do
      expect(described_class.ranked.first.rank).to be 1
      expect(described_class.ranked.second.rank).to be 2
    end
  end

  describe ".top(n)" do

    before do 
      10.times { |i| FactoryGirl.create(factory, rank: i + 1) }
    end
    
    it "returns the top n #{described_class.model_name.plural}" do
      expect(described_class.top(2).first.rank).to be 1
      expect(described_class.top(2).second.rank).to be 2
    end
  end

  describe "#hot" do
    
    context "when ranked in top 5" do
      before { subject.rank = 5 }
      it { should be_hot }
    end

    context "when ranked below 5" do
      before { subject.rank = 6 }
      it { should_not be_hot }
    end
  end

  describe ".hot" do

    before do 
      10.times { |i| FactoryGirl.create(factory, rank: i + 1) }
    end
    
    it "returns the top 5 #{described_class.model_name.plural}" do
      expect(described_class.hot.map(&:rank)).to eq [1,2,3,4,5]
    end
  end  
end
