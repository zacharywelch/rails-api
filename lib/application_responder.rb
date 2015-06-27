class ApplicationResponder < ActionController::Responder
  include Responders::HttpCacheResponder
  include Responders::PaginationResponder

  # monkey-patches Responder so errors exclude "errors" key
  def json_resource_errors
    resource.errors
  end
end
