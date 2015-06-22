# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  name       :string
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :song do
    name "MyString"
    album nil
  end
end
