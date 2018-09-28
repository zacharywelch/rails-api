require 'rails_helper'

describe "Albums API" do

  describe "GET /albums" do

    before do
      create_list :album, 10
      get '/albums'
    end

    it "returns albums" do
      expect(response).to be_success
      expect(response).to match_response_schema("albums")
      expect(json.length).to be 10
    end
  end

  it_has_behavior "pagination", "/albums", :album

  describe "GET /artists/:artist_id/albums" do

    let(:artist) do
      create :artist, albums: create_list(:album, 10)
    end

    before do
      get "/artists/#{artist.id}/albums"
    end

    it "returns albums" do
      expect(response).to be_success
      expect(response).to match_response_schema("albums")
      expect(json.length).to be 10
    end
  end

  describe "GET /albums/:id" do

    let(:album) do
      create :album, name: "Foo", released_at: "2008-01-27", rank: 1,
                                  songs: create_list(:song, 10)
    end

    before do
      get "/albums/#{album.id}"
    end

    it "returns an album" do
      expect(response).to be_success
      expect(response).to match_response_schema("album")
    end

    it "returns album by id" do
      expect(json["id"]).to be album.id
    end

    it "returns album with name" do
      expect(json["name"]).to eq "Foo"
    end

    it "returns album with released_at" do
      expect(json["released_at"]).to eq "2008-01-27"
    end

    it "returns album with rank" do
      expect(json["rank"]).to be 1
    end

    it "returns songs for album" do
      expect(json["songs"].length).to be 10
    end

    it_behaves_like "not found", "/albums/missing"
  end

  describe "POST /artists/:artist_id/albums" do

    let(:artist) { create :artist }

    context "with valid params" do

      before do
        post "/artists/#{artist.id}/albums", name: "Foo",
          released_at: "2008-01-27"
      end

      it "creates an album" do
        expect(response).to be_created
        expect(response).to match_response_schema("album")
        expect(json["name"]).to eq "Foo"
        expect(json["released_at"]).to eq "2008-01-27"
      end
    end

    context "with invalid params" do

      before do
        post "/artists/#{artist.id}/albums", name: nil
      end

      it_behaves_like "unprocessable"
    end
  end

  describe "PUT /albums/:id" do

    let(:album) { create :album, name: "Foo" }

    context "with valid params" do

      before do
        put "/albums/#{album.id}", name: "Bar"
      end

      it "updates an album" do
        expect(response).to be_success
        expect(response).to match_response_schema("album")
        expect(json["name"]).to eq "Bar"
      end
    end

    context "with invalid params" do

      before do
        put "/albums/#{album.id}", name: nil
      end

      it_behaves_like "unprocessable"
    end
  end

  describe "DELETE /albums/:id" do

    let(:album) { create :album }

    before do
      delete "/albums/#{album.id}"
    end

    it "deletes an album" do
      expect(response).to be_success
      get "/albums/#{album.id}"
      expect(response).to be_missing
    end
  end

  describe "GET /albums/recent" do

    before do
      create_list :album, 5
      create_list :recent_album, 5
      get '/albums/recent'
    end

    it "returns albums released recently" do
      expect(response).to be_success
      expect(response).to match_response_schema("albums")
      expect(json.length).to be 5
    end
  end

  describe "GET /albums/ranked" do

    before do
      create_list :album, 10
      get '/albums/ranked'
    end

    it "returns artists by rank" do
      expect(response).to be_success
      expect(response).to match_response_schema("albums")
      expect(json.length).to be 10
    end
  end

  describe "GET /albums/hot" do

    before do
      create_list :album, 10
      get '/albums/hot'
    end

    it "returns top 5 albums" do
      expect(response).to be_success
      expect(response).to match_response_schema("albums")
      expect(json.length).to be 5
    end
  end
end
