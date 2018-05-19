class MusicLibraryController

  def initialize( path="./db/mp3s" )
    MusicImporter.new( path ).import
  end

  def call
    input = ""

    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      # valid_inputs = ['list songs', 'list artists', 'list genres', 'list artist', 'list genre', 'play song', 'exit']

      input = gets.strip.downcase

      case input
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end

  end

  def list_songs
    # Sort songs alphabetically by song name
    songs = Song.all.sort { |song_a, song_b| song_a.name <=> song_b.name }

    # Print list of sorted songs
    songs.each.with_index( 1 ) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    # Sort artists alphabetically by name
    artists = Artist.all.sort { |artist_a, artist_b| artist_a.name <=> artist_b.name }

    # Print list of sorted artists
    artists.each.with_index( 1 ) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
    # Sort genres alphabetically by name
    genres = Genre.all.sort { |genre_a, genre_b| genre_a.name <=> genre_b.name }

    # Print list of sorted genres
    genres.each.with_index( 1 ) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if Artist.find_by_name( input )
      artist = Artist.find_by_name( input )

      sorted_songs = artist.songs.sort { |song_a, song_b| song_a.name <=> song_b.name }
      sorted_songs.each.with_index( 1 ) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if Genre.find_by_name( input )
      genre = Genre.find_by_name( input )

      sorted_songs = genre.songs.sort { |song_a, song_b| song_a.name <=> song_b.name }
      sorted_songs.each.with_index( 1 ) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.strip.to_i

    if song_number > 0 && song_number <= Song.all.length
      songs = Song.all.sort { |song_a, song_b| song_a.name <=> song_b.name }
      song_to_play = songs[ song_number - 1 ]
    end

    puts "Playing #{song_to_play.name} by #{song_to_play.artist.name}" if song_to_play
  end

end
