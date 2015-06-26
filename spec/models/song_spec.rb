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

  it_behaves_like "ranked"

  context "when name is not present" do
    before { song.name = nil }
    it { should_not be_valid }
  end
end
