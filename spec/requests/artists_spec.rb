require 'rails_helper'

describe "Artists API" do
  
  let(:json) { JSON.parse(response.body) }
    
  describe "GET /api/artists" do
    
    before do
      10.times { FactoryGirl.create(:artist) }
      get '/api/artists'
    end

    it "returns artists" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to eq 10
    end
  end

  describe "GET /api/artists/:id" do
    
    subject(:artist) { FactoryGirl.create(:artist, name: "Foo") }
    
    before do
      get "/api/artists/#{artist.id}"
    end

    it "returns artist by id" do
      expect(response).to be_success
      expect(json["id"]).to be artist.id
    end

    it "returns artist with name" do
      expect(response).to be_success
      expect(json["name"]).to eq "Foo"
    end

    it "returns 404 for artist that doesn't exist" do
      get '/api/artists/missing'
      expect(response).to be_missing
    end
  end

  describe "POST /api/artists" do
    
    before do
      post '/api/artists', { name: "Foo" }
    end

    it "creates an artist" do
      expect(response).to be_created
      expect(json).to include "id"
      expect(json["name"]).to eq "Foo"
    end
  end  
end
