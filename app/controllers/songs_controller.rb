class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  def index
    @songs = Song.all
    respond_with(@songs)
  end

  def show
    respond_with(@song)
  end

  def create
    @song = Song.new(song_params)
    @song.save
    respond_with(@song)
  end

  def update
    @song.update(song_params)
    respond_with(@song)
  end

  def destroy
    @song.destroy
    respond_with(@song)
  end

  private
    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.permit(:name, :album_id)
    end
end
