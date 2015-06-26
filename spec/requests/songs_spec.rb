require 'rails_helper'

describe "Songs API" do
  
  let(:json) { JSON.parse(response.body) }
    
  describe "GET /songs" do
    
    before do
      FactoryGirl.create_list :song, 10
      get '/songs'
    end

    it "returns songs" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end
  end

  it_has_behavior "pagination", "/songs", :song

  describe "GET /albums/:album_id/songs" do
    
    let(:album) do
      FactoryGirl.create(:album, songs: FactoryGirl.create_list(:song, 10))
    end

    before do
      get "/albums/#{album.id}/songs"
    end

    it "returns songs" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end
  end

  describe "GET /songs/:id" do
    
    let(:song) do
      FactoryGirl.create(:song, name: "Foo", rank: 1)
    end
    
    before do
      get "/songs/#{song.id}"
    end

    it "returns song by id" do
      expect(response).to be_success
      expect(json["id"]).to be song.id
    end

    it "returns song with name" do
      expect(response).to be_success
      expect(json["name"]).to eq "Foo"
    end

    it "returns song with rank" do
      expect(response).to be_success
      expect(json["rank"]).to be 1
    end

    it "returns 404 for song that doesn't exist" do
      get '/songs/missing'
      expect(response).to be_missing
    end
  end

  describe "POST /albums/:album_id/songs" do
    
    let(:album) { FactoryGirl.create(:album) }
    
    before do
      post "/albums/#{album.id}/songs", name: "Foo"
    end

    it "creates an song" do
      expect(response).to be_created
      expect(json).to include "id"
      expect(json["name"]).to eq "Foo"
      expect(json["album_id"]).to be album.id
    end
  end

  describe "PUT /songs/:id" do
    
    let(:song) { FactoryGirl.create(:song, name: "Foo") }

    before do
      put "/songs/#{song.id}", name: "Bar"
    end

    it "updates a song" do
      expect(response.status).to be 204
      expect(response.body).to be_empty
    end
  end

  describe "DELETE /songs/:id" do
    
    let(:song) { FactoryGirl.create(:song) }
    
    before do
      delete "/songs/#{song.id}"
    end

    it "deletes an song" do
      expect(response).to be_success
      get "/songs/#{song.id}"
      expect(response).to be_missing
    end
  end

  describe "GET /songs/top_25" do
    
    before do
      FactoryGirl.create_list :song, 30
      get '/songs/top_25'
    end

    it "returns top 25 songs" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 25
    end
  end

  describe "GET /songs/hot" do
    
    before do
      FactoryGirl.create_list :song, 10
      get '/songs/hot'
    end

    it "returns top 5 songs" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 5
    end
  end 
end