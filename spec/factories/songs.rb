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

FactoryGirl.define do
  factory :song do
    sequence(:name) { |n| "Song #{n}" }
    sequence(:rank)
    album
  end
end
