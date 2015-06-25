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
    sequence(:name) { |n| "Album #{n}" }
    released_at "2008-01-27"
    artist
  end
end
