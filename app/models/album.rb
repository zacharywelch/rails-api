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
  belongs_to :artist
  has_many :songs

  validates :name, presence: true

  scope :recent_releases, -> { where("released_at > ?", 1.month.ago) }
  scope :ranked, -> { order(:rank) }
  scope :top, ->(n) { ranked.limit(n) }
  scope :hot, -> { top(5) }

  def hot?
    rank.between?(1, 5)
  end
end
