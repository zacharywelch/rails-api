require "application_responder"

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  self.responder = ApplicationResponder
  respond_to :json

  def not_found
    render json: "Resource not found (404)", status: :not_found
  end
end
