require 'rails_helper'

describe "Albums API" do
  
  let(:json) { JSON.parse(response.body) }
    
  describe "GET /albums" do
    
    before do
      FactoryGirl.create_list :album, 10
      get '/albums'
    end

    it "returns albums" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end
  end

  describe "GET /albums/:id" do
    
    let(:album) do
      FactoryGirl.create(:album, name: "Foo", released_at: "2008-01-27", rank: 1,
                                 songs: FactoryGirl.create_list(:song, 10))
    end
    
    before do
      get "/albums/#{album.id}"
    end

    it "returns album by id" do
      expect(response).to be_success
      expect(json["id"]).to be album.id
    end

    it "returns album with name" do
      expect(response).to be_success
      expect(json["name"]).to eq "Foo"
    end

    it "returns album with released_at" do
      expect(response).to be_success
      expect(json["released_at"]).to eq "2008-01-27"
    end

    it "returns album with rank" do
      expect(response).to be_success
      expect(json["rank"]).to be 1
    end

    it "returns 404 for album that doesn't exist" do
      get '/albums/missing'
      expect(response).to be_missing
    end

    it "returns songs for album" do
      expect(response).to be_success
      expect(json["songs"]).to be_an(Array)
      expect(json["songs"].length).to be 10
    end
  end

  describe "POST /albums" do
    
    before do
      post '/albums', name: "Foo", released_at: "2008-01-27"
    end

    it "creates an album" do
      expect(response).to be_created
      expect(json).to include "id"
      expect(json["name"]).to eq "Foo"
      expect(json["released_at"]).to eq "2008-01-27"
    end
  end

  describe "PUT /albums/:id" do
    
    let(:album) { FactoryGirl.create(:album, name: "Foo") }

    before do
      put "/albums/#{album.id}", name: "Bar"
    end

    it "updates an album" do
      expect(response.status).to be 204
      expect(response.body).to be_empty
    end
  end

  describe "DELETE /albums/:id" do
    
    let(:album) { FactoryGirl.create(:album) }
    
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
      FactoryGirl.create_list :album, 5, released_at: 2.months.ago
      FactoryGirl.create_list :recent_album, 5
      get '/albums/recent'
    end

    it "returns albums released recently" do
      expect(response).to be_success
      expect(json.length).to be 5
    end
  end  

  it_has_behavior "pagination", "/albums/recent", :recent_album 

  describe "GET /albums/ranked" do
    
    before do
      FactoryGirl.create_list :album, 10
      get '/albums/ranked'
    end

    it "returns artists by rank" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 10
    end
  end

  describe "GET /albums/hot" do
    
    before do
      FactoryGirl.create_list :album, 10
      get '/albums/hot'
    end

    it "returns top 5 albums" do
      expect(response).to be_success
      expect(json).to be_an(Array)
      expect(json.length).to be 5
    end
  end  
end
