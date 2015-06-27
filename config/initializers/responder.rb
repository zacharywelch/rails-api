ActionController::Responder.class_eval do
  # remove :errors root from json
  def json_resource_errors
    resource.errors
  end
end
