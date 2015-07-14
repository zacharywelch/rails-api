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
    create :album, name: "Foo", released_at: "2008-01-27"
  end

  it { should respond_to(:name) }
  it { should respond_to(:released_at) }
  it { should respond_to(:rank) }  
  it { should respond_to(:artist_id) }
  it { should respond_to(:artist) }
  it { should respond_to(:songs) }

  it { should be_valid }

  it { should validate_presence_of(:name) }

  it_behaves_like "ranked"  

  describe ".recent_releases" do

    it "includes albums released within a month" do
      album = create :recent_album
      expect(Album.recent_releases).to include album
    end

    it "excludes albums released more than a month ago" do
      album = create :album, released_at: 2.months.ago
      expect(Album.recent_releases).to_not include album
    end
  end
end
