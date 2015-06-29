require 'rails_helper'

describe "Artists API" do
  
  let(:json) { JSON.parse(response.body) }
    
  describe "GET /artists" do
    
    before do
      create_list :artist, 10
      get '/artists'
    end

    it "returns artists" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end
  end

  describe "GET /artists/:id" do
    
    let(:artist) { create :artist, name: "Foo", rank: 1 }
    
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

    it "returns artist with rank" do
      expect(response).to be_success
      expect(json["rank"]).to be 1
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
    
    let(:artist) { create :artist, name: "Foo" }

    before do
      put "/artists/#{artist.id}", name: "Bar"
    end

    it "updates an artist" do
      expect(response).to be_success
      expect(json["name"]).to eq "Bar"
    end
  end

  describe "DELETE /artists/:id" do
    
    let(:artist) { create :artist }
    
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
      create_list :artist, 10, featured: true
      get '/artists/featured'
    end

    it "returns artists" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end

    it "returns artists that are featured" do
      expect(response).to be_success
      json.each do |artist|
        expect(artist["featured"]).to be true
      end 
    end
  end  

  describe "GET /artists/ranked" do
    
    before do
      create_list :artist, 10
      get '/artists/ranked'
    end

    it "returns artists by rank" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end
  end

  describe "GET /artists/hot" do
    
    before do
      create_list :artist, 10
      get '/artists/hot'
    end

    it "returns top 5 artists" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 5
    end
  end  
end
