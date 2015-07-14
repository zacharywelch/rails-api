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
  
  subject(:song) { create :song, name: "Foo" }

  it { should respond_to(:name) }
  it { should respond_to(:rank) }
  it { should respond_to(:album) }

  it { should be_valid }

  it { should validate_presence_of(:name) }  

  it_behaves_like "ranked"
end
