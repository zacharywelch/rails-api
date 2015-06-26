json.extract! @album, :id, :name, :released_at, :artist_id, :rank, :created_at, :updated_at

json.songs @album.songs do |song|
  json.extract! song, :id, :name, :album_id
  json.url song_url(song, format: :json)
end