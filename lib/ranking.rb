module Ranking
  extend ActiveSupport::Concern

  class_methods do    
    
    def has_ranking
      instance_eval do
        scope :ranked, -> { order(:rank) }
        scope :top, ->(n) { ranked.limit(n) }
        scope :hot, -> { top(5) }
      end
    
      class_eval do
        def hot?
          rank.between?(1, 5)
        end
      end
    end
  end  
end
