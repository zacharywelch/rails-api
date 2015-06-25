require 'rails_helper'

describe Artist do
  
  subject(:artist) { FactoryGirl.create(:artist, name: "Foo") }

  it { should respond_to(:name) }
  it { should respond_to(:albums) }
  it { should respond_to(:songs) }

  it { should be_valid }

  context "when name is not present" do
    before { artist.name = nil }
    it { should_not be_valid }
  end
end
