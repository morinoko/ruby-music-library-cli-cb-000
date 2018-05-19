class Song
  extend Concerns::Findable

  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []

  def initialize( name, artist=nil, genre=nil )
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create( name )
    song = self.new( name )
    song.save
    song
  end

  # new song from mp3 file formatted "Thundercat - For Love I Come - dance.mp3"
  def self.new_from_filename( filename )
    artist_name, song_name, genre_name = filename.chomp(".mp3").split(" - ")
    artist = Artist.find_or_create_by_name( artist_name )
    genre = Genre.find_or_create_by_name( genre_name )

    self.new( song_name, artist, genre )
  end

  def self.create_from_filename( filename )
    song = self.new_from_filename( filename )
    song.save
  end

  def artist=( artist )
    @artist = artist # need this or code will break!
    artist.add_song( self )
  end

  def genre=( genre )
    @genre = genre
    genre.songs << self unless genre.songs.include?( self )
  end

end
