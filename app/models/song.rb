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
  has_ranking
  belongs_to :album

  validates :name, presence: true
end
