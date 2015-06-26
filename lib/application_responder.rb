class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder
  include Responders::PaginationResponder

  # Redirects resources to the collection path (index action) instead
  # of the resource path (show action) for POST/PUT/DELETE requests.
  # include Responders::CollectionResponder

  # monkey-patches Responder so errors exclude "errors" key
  def json_resource_errors
    resource.errors
  end
end
