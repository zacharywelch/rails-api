module Responders::JsonResponder    
  
  # return resource with 200 instead of 204 for updates
  def api_behavior
    if put?
      display resource, status: :ok, location: api_location
    else
      super
    end    
  end

  # remove :errors root from json
  def json_resource_errors
    resource.errors
  end  
end
