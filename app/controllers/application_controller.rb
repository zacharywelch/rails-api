class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ApiFilters

  self.responder = ApplicationResponder
  respond_to :json
end
