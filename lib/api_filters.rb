module ApiFilters
  extend ActiveSupport::Concern
  
  included do 
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  def not_found
    render json: "Resource not found (404)", status: :not_found
  end
end
