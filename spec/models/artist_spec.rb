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

  it_behaves_like "ranked"

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
end
