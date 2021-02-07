require_relative '../../lib/slug'

class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists
    has_many :artists, through: :songs

    include Slug
    extend Slug
end

