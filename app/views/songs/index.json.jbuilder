json.paginate!(@songs) do |song|
  json.extract! song, :id, :name, :album_id, :rank
  json.url song_url(song, format: :json)
end
