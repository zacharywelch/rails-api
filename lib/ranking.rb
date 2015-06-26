module Ranking
  extend ActiveSupport::Concern

  included do
    scope :ranked, -> { order(:rank) }
    scope :top, ->(n) { ranked.limit(n) }
    scope :hot, -> { top(5) }
  end

  def hot?
    rank.between?(1, 5)
  end  
end
