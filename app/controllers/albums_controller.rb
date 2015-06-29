class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]
  before_action :set_artist

  def index
    @albums = albums.page(params[:page])
    respond_with(@albums)
  end

  def show
    respond_with(@album)
  end

  def create
    @album = albums.new(album_params)
    @album.save
    respond_with(@album)
  end

  def update
    @album.update(album_params)
    respond_with(@album)
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  def recent
    @albums = Album.recent_releases
    respond_with(@albums)
  end

  def ranked
    @albums = Rails.cache.fetch "albums:ranked", expires_in: 5.seconds do
      Album.ranked.to_a
    end
    respond_with(@albums)
  end

  def hot
    @albums = Album.hot
    respond_with(@albums)
  end

  private
    def albums
      @artist ? @artist.albums : Album
    end

    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.permit(:name, :released_at, :artist_id)
    end

    def set_artist
      @artist = Artist.find(params[:artist_id]) if params[:artist_id]
    end
end
