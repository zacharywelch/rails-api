require 'rails_helper'

describe "Albums" do
  describe "GET /albums" do
    it "works! (now write some real specs)" do
      get albums_path
      expect(response).to have_http_status(200)
    end
  end
end
