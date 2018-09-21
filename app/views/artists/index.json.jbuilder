json.paginate!(@artists) do |artist|
  json.extract! artist, :id, :name, :featured, :rank
  json.url artist_url(artist, format: :json)
end
