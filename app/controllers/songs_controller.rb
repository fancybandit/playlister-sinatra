require 'rack-flash'

class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        @artists = Artist.all
        erb :'songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        @artists = Artist.all
        erb :'songs/edit'
    end

    post '/songs' do
        @song = Song.create(name: params[:song][:name])

        if params[:song][:artist_id]
            @song.artist = Artist.find(params[:song][:artist_id])
        end
        if !params[:artist][:name].empty?
            detected = Artist.all.detect do |artist|
                artist.name == params[:artist][:name]
            end
            if detected
                @song.artist = detected
            else
                @song.artist = Artist.create(params[:artist])
            end
        end

        if !params[:genre][:name].empty?
            @song.genres << Genre.create(params[:genre])
        end
        if params[:song][:genre_ids]
            params[:song][:genre_ids].each do |id|
                @song.genres << Genre.find(id)
            end
        end

        @song.save

        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])

        if params[:song][:name] != @song.name
            @song.update(name: params[:song][:name])
        end

        if params[:song][:artist_id] != @song.artist_id
            @song.artist = Artist.find(params[:song][:artist_id])
        end

        if params[:song][:genre_ids]
            @song.genres.each do |genre|
                if params[:song][:genre_ids].none? {|id| id == genre.id }
                    @song.genres.delete(genre)
                end
            end

            params[:song][:genre_ids].each do |id|
                @song.genres << Genre.find(id)
            end
        end

        if !params[:artist][:name].empty?
            detected = Artist.all.detect do |artist|
                artist.name == params[:artist][:name]
            end
            if detected
                @song.artist = detected
            else
                @song.artist = Artist.create(params[:artist])
            end
        end

        if !params[:genre][:name].empty?
            detected = Genre.all.detect do |genre|
                genre.name == params[:genre][:name]
            end
            if detected
                @song.genre << detected
            else
                @song.genres << Genre.create(params[:genre])
            end
        end

        @song.save

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end

end

