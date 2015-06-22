json.array!(@albums) do |album|
  json.extract! album, :id, :name, :released_at, :artist_id
  json.url album_url(album, format: :json)
end
