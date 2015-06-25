class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]

  def index
    @artists = Artist.all
    respond_with(@artists)
  end

  def show
    respond_with(@artist)
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.save
    respond_with(@artist)
  end

  def update
    @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

  def featured
    @artists = Artist.featured
    respond_with(@artists)
  end

  def ranked
    @artists = Rails.cache.fetch "ranked", expires_in: 5.seconds do
      Artist.ranked.to_a
    end
    respond_with(@artists)
  end

  def hot
    @artists = Artist.top(5)
    respond_with(@artists)
  end

  private
    def set_artist
      @artist = Artist.find(params[:id])
    end

    def artist_params
      params.permit(:name, :featured)
    end
end
