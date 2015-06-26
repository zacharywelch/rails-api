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

class Artist < ActiveRecord::Base
  has_many :albums
  has_many :songs, through: :albums

  validates :name, presence: true

  scope :featured, -> { where(featured: true) }
  scope :ranked, -> { order(:rank) }
  scope :top, ->(n) { ranked.limit(n) }
  scope :hot, -> { top(5) }

  def hot?
    rank.between?(1, 5)
  end
end