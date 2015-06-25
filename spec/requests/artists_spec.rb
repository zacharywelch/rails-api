require 'rails_helper'

describe "Artists API" do
  
  let(:json) { JSON.parse(response.body) }
    
  describe "GET /artists" do
    
    before do
      10.times { FactoryGirl.create(:artist) }
      get '/artists'
    end

    it "returns artists" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to eq 10
    end
  end

  describe "GET /artists/:id" do
    
    let(:artist) { FactoryGirl.create(:artist, name: "Foo") }
    
    before do
      get "/artists/#{artist.id}"
    end

    it "returns artist by id" do
      expect(response).to be_success
      expect(json["id"]).to be artist.id
    end

    it "returns artist with name" do
      expect(response).to be_success
      expect(json["name"]).to eq "Foo"
    end

    it "returns artist with featured" do
      expect(response).to be_success
      expect(json["featured"]).to be false
    end

    it "returns 404 for artist that doesn't exist" do
      get '/artists/missing'
      expect(response).to be_missing
    end
  end

  describe "POST /artists" do
    
    before do
      post '/artists', name: "Foo", featured: true
    end

    it "creates an artist" do
      expect(response).to be_created
      expect(json).to include "id"
      expect(json["name"]).to eq "Foo"
      expect(json["featured"]).to be true
    end
  end

  describe "PUT /artists/:id" do
    
    let(:artist) { FactoryGirl.create(:artist, name: "Foo") }

    before do
      put "/artists/#{artist.id}", name: "Bar"
    end

    it "updates an artist" do
      expect(response.status).to be 204
      expect(response.body).to be_empty
    end
  end

  describe "DELETE /artists/:id" do
    
    let(:artist) { FactoryGirl.create(:artist) }
    
    before do
      delete "/artists/#{artist.id}"
    end

    it "deletes an artist" do
      expect(response).to be_success
      get "/artists/#{artist.id}"
      expect(response).to be_missing
    end
  end  

  describe "GET /artists/featured" do
    
    before do
      10.times { FactoryGirl.create(:artist, featured: true) }
      get '/artists/featured'
    end

    it "returns artists" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to eq 10
    end

    it "returns artists that are featured" do
      expect(response).to be_success
      json.each do |artist|
        expect(artist["featured"]).to be true
      end 
    end
  end  
end
