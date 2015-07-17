class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  self.responder = ApplicationResponder
  respond_to :json

  private
    def sort_by
      { params[:sort] => params[:direction] || :asc } if params[:sort]
    end
end
