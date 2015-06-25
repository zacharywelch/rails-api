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
#

require 'rails_helper'

describe Album do

  subject(:album) do
    FactoryGirl.create(:album, name: "Foo", released_at: "2008-01-27")
  end

  it { should respond_to(:name) }
  it { should respond_to(:released_at) }
  it { should respond_to(:artist_id) }
  it { should respond_to(:artist) }
  it { should respond_to(:songs) }

  it { should be_valid }

  context "when name is not present" do
    before { album.name = nil }
    it { should_not be_valid }
  end
end
