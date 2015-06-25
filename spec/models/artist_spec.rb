# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  featured   :boolean          default("f")
#

require 'rails_helper'

describe Artist do
  
  subject(:artist) { FactoryGirl.create(:artist, name: "Foo") }

  it { should respond_to(:name) }
  it { should respond_to(:albums) }
  it { should respond_to(:songs) }

  it { should be_valid }
  it { should_not be_featured }

  context "when name is not present" do
    before { artist.name = nil }
    it { should_not be_valid }
  end
end
