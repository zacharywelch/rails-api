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

FactoryGirl.define do
  factory :album do
    name "MyString"
    released_at "2015-06-21"
    artist nil
  end
end
