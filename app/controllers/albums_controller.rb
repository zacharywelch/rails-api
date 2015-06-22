class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  def index
    @albums = Album.all
    respond_with(@albums)
  end

  def show
    respond_with(@album)
  end

  def create
    @album = Album.new(album_params)
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

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :released_at, :artist_id)
    end
end
