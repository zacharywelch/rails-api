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

class Album < ActiveRecord::Base
  has_ranking
  belongs_to :artist
  has_many :songs

  validates :name, presence: true

  scope :recent_releases, -> { where("released_at > ?", 1.month.ago) }
end
