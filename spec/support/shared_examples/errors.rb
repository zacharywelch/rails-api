require 'rails_helper'

shared_examples "not found" do |path|

  before do
    get path
  end

  it "returns 404 for resource doesn't exist" do
    expect(response).to be_missing
    expect(response).to match_json_schema "errors/not_found"
  end
end

shared_examples "unprocessable" do

  it "returns 422 for invalid resource" do
    expect(response).to be_unprocessable
    expect(response).to match_json_schema "errors/unprocessable"
  end
end
