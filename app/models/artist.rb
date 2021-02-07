require_relative '../../lib/slug'

class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres
    has_many :genres, through: :songs

    include Slug
    extend Slug
end

