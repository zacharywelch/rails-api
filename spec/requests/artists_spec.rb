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
    
    let(:artist) { FactoryGirl.create(:artist, name: "Foo") }
    
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
      post '/api/artists', name: "Foo"
    end

    it "creates an artist" do
      expect(response).to be_created
      expect(json).to include "id"
      expect(json["name"]).to eq "Foo"
    end
  end

  describe "PUT /api/artists/:id" do
    
    let(:artist) { FactoryGirl.create(:artist, name: "Foo") }

    before do
      put "/api/artists/#{artist.id}", name: "Bar"
    end

    it "updates an artist" do
      expect(response.status).to be 204
      expect(response.body).to be_empty
    end
  end

  describe "DELETE /api/artists/:id" do
    
    let(:artist) { FactoryGirl.create(:artist) }
    
    before do
      delete "/api/artists/#{artist.id}"
    end

    it "deletes an artist" do
      expect(response).to be_success
      get "/api/artists/#{artist.id}"
      expect(response).to be_missing
    end
  end  
end
