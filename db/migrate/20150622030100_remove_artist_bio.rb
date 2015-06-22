class RemoveArtistBio < ActiveRecord::Migration
  def change
    remove_column :artists, :bio
  end
end
