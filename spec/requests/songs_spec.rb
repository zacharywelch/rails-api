require 'rails_helper'

describe "Songs API" do

  describe "GET /songs" do

    before do
      create_list :song, 10
      get '/songs'
    end

    it "returns songs" do
      expect(response).to be_success
      expect(response).to match_json_schema("songs")
      expect(json.length).to be 10
    end
  end

  it_has_behavior "pagination", "/songs", :song

  describe "GET /albums/:album_id/songs" do

    let(:album) do
      create :album, songs: create_list(:song, 10)
    end

    before do
      get "/albums/#{album.id}/songs"
    end

    it "returns songs" do
      expect(response).to be_success
      expect(response).to match_json_schema("songs")
      expect(json.length).to be 10
    end
  end

  describe "GET /songs/:id" do

    let(:song) do
      create :song, name: "Foo", rank: 1
    end

    before do
      get "/songs/#{song.id}"
    end

    it "returns a song" do
      expect(response).to be_success
      expect(response).to match_json_schema("song")
    end

    it "returns song by id" do
      expect(json["id"]).to be song.id
    end

    it "returns song with name" do
      expect(json["name"]).to eq "Foo"
    end

    it "returns song with rank" do
      expect(json["rank"]).to be 1
    end

    it_behaves_like "not found", "/songs/missing"
  end

  describe "POST /albums/:album_id/songs" do

    let(:album) { create :album }

    context "with valid params" do

      before do
        post "/albums/#{album.id}/songs", name: "Foo"
      end

      it "creates a song" do
        expect(response).to be_created
        expect(response).to match_json_schema("song")
        expect(json["name"]).to eq "Foo"
        expect(json["album_id"]).to be album.id
      end
    end

    context "with invalid params" do

      before do
        post "/albums/#{album.id}/songs", name: nil
      end

      it_behaves_like "unprocessable"
    end
  end

  describe "PUT /songs/:id" do

    let(:song) { create :song, name: "Foo" }

    context "with valid params" do

      before do
        put "/songs/#{song.id}", name: "Bar"
      end

      it "updates a song" do
        expect(response).to be_success
        expect(response).to match_json_schema("song")
        expect(json["name"]).to eq "Bar"
      end
    end

    context "with invalid params" do

      before do
        put "/songs/#{song.id}", name: nil
      end

      it_behaves_like "unprocessable"
    end
  end

  describe "DELETE /songs/:id" do

    let(:song) { create :song }

    before do
      delete "/songs/#{song.id}"
    end

    it "deletes a song" do
      expect(response).to be_success
      get "/songs/#{song.id}"
      expect(response).to be_missing
    end
  end

  describe "GET /songs/top_25" do

    before do
      create_list :song, 30
      get '/songs/top_25'
    end

    it "returns top 25 songs" do
      expect(response).to be_success
      expect(response).to match_json_schema("songs")
      expect(json.length).to be 25
    end
  end

  describe "GET /songs/hot" do

    before do
      create_list :song, 10
      get '/songs/hot'
    end

    it "returns top 5 songs" do
      expect(response).to be_success
      expect(response).to match_json_schema("songs")
      expect(json.length).to be 5
    end
  end
end
