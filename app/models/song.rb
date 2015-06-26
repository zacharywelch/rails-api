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

class Song < ActiveRecord::Base
  belongs_to :album

  validates :name, presence: true

  scope :ranked, -> { order(:rank) }
  scope :top, ->(n) { ranked.limit(n) }
  scope :hot, -> { top(5) }

  def hot?
    rank.between?(1, 5)
  end
end
