require_relative '../../lib/slug'

class SongGenre < ActiveRecord::Base
    belongs_to :song
    belongs_to :genre

    include Slug
    extend Slug
end

