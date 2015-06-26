artist = Artist.create(name: "OMI", featured: true)
album = Album.create(name: "Cheerleader (Felix Jaehn Remix Radio Edit)", 
                     artist: artist, released_at: "May 20, 2014")
Song.create(name: "Cheerleader", album: album)


artist = Artist.create(name: "Walk the Moon")
album = Album.create(name: "Talking is Hard", artist: artist, 
                     released_at: "Nov 28, 2014")
Song.create(name: "Different Colors", album: album)
Song.create(name: "Sidekick", album: album)
Song.create(name: "Shut up and Dance", album: album)
Song.create(name: "Up 2 U", album: album)
Song.create(name: "Avalanche", album: album)
Song.create(name: "Portugal", album: album)
Song.create(name: "Down in the Dumps", album: album)
Song.create(name: "Work This Body", album: album)
Song.create(name: "Spend Your $$$", album: album)


artist = Artist.create(name: "Jason Derulo")
album = Album.create(name: "Everything Is 4", artist: artist, 
                     released_at: "May 29, 2015")
Song.create(name: "Want to Want Me", album: album)
Song.create(name: "Cheyanne", album: album)
Song.create(name: "Get Ugly", album: album)
Song.create(name: "Pull-Up", album: album)
Song.create(name: "Love Like That", album: album)
Song.create(name: "Painkiller", album: album)
Song.create(name: "Broke", album: album)
Song.create(name: "Try Me", album: album)
Song.create(name: "Love Me Down", album: album)
Song.create(name: "Trade Hearts", album: album)


artist = Artist.create(name: "Tove Lo")
album = Album.create(name: "Queen of the Clouds", artist: artist, 
                     released_at: "Sep 30, 2014")
Song.create(name: "The Sex", album: album)
Song.create(name: "My Gun", album: album)
Song.create(name: "Like Em Young", album: album)
Song.create(name: "Talking Body", album: album)
Song.create(name: "Timebomb", album: album)
Song.create(name: "The Love", album: album)
Song.create(name: "Moments", album: album)
Song.create(name: "The Way That I Am", album: album)
Song.create(name: "Got Love", album: album)
Song.create(name: "Not On Drugs", album: album)
Song.create(name: "The Pain", album: album)
Song.create(name: "Thousand Miles", album: album)
Song.create(name: "Habits (Stay High)", album: album)


artist = Artist.create(name: "Ellie Goulding")
album = Album.create(name: "Lights", artist: artist, released_at: "Mar 8, 2011")
Song.create(name: "Lights", album: album)
Song.create(name: "Guns and Horses", album: album)
Song.create(name: "Starry Eyed", album: album)
Song.create(name: "This Love (Will Be Your Downfall)", album: album)
Song.create(name: "Under the Sheets", album: album)
Song.create(name: "The Writer", album: album)
Song.create(name: "Animal", album: album)
Song.create(name: "Every Time You Go", album: album)
Song.create(name: "Your Biggest Mistake", album: album)
Song.create(name: "Salt Skin", album: album)
Song.create(name: "Your Song", album: album)

album = Album.create(name: "Halcyon Days", artist: artist, 
                     released_at: "Aug 27, 2013")
Song.create(name: "Don't Say a Word", album: album)
Song.create(name: "My Blood", album: album)
Song.create(name: "Anything Could Happen", album: album)
Song.create(name: "Only You", album: album)
Song.create(name: "Halcyon", album: album)
Song.create(name: "Figure 8", album: album)
Song.create(name: "Joy", album: album)
Song.create(name: "Hanging On", album: album)
Song.create(name: "Explosions", album: album)
Song.create(name: "I Know You Care", album: album)
Song.create(name: "Atlantis", album: album)
Song.create(name: "I Need Your Love", album: album)


artist = Artist.create(name: "Natalie La Rose", featured: true)
album = Album.create(name: "Somebody (feat. Jeremih) - Single", artist: artist,
                     released_at: "Jan 6, 2015")
Song.create(name: "Somebody (feat. Jeremih)", album: album)

album = Album.create(name: "Around the World (feat. Fetty Wap) - Single", 
                     artist: artist, released_at: "Jun 5, 2015")
Song.create(name: "Around the World (feat. Fetty Wap)", album: album)


# Randomize rankings for artists, albums, and songs
[Artist, Album, Song].each do |klass|
  klass.all.shuffle.each_with_index do |row, i|
    row.update_attributes(rank: i + 1)
  end
end