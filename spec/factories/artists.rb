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

FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "Artist #{n}" }
    sequence(:rank)
  end
end
