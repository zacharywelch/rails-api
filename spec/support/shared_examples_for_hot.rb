require 'rails_helper'

RSpec.shared_examples "hot" do

  let(:factory) { described_class.name.underscore.to_sym }

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
