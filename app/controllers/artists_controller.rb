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
    @artists = Rails.cache.fetch "featured", expires_in: 5.seconds do 
      Artist.featured.to_a
    end
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
