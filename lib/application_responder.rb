class ApplicationResponder < ActionController::Responder
  include Responders::HttpCacheResponder
  include Responders::JsonResponder
end
