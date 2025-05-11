# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

data = JSON.parse(File.read('db/streams_data.json'))

p 'destroy_all'
App.destroy_all
Movie.destroy_all
TvShow.destroy_all
Channel.destroy_all

p 'movies'
data['movies'].each do |movie_data|
  movie = Movie.create!(movie_data.slice('original_title', 'year', 'duration_in_seconds'))
  movie_data['availabilities'].each do |availability|
    app = App.find_or_create_by!(name: availability['app'])
    movie.availabilities.create!(app: app, market: availability['market'])
  end
end

p 'tv_shows'
data['tv_shows'].each do |tv_data|
  tv = TvShow.create!(tv_data.slice('original_title', 'year', 'duration_in_seconds'))
  tv_data['availabilities'].each do |availability|
    app = App.find_or_create_by!(name: availability['app'])
    tv.availabilities.create!(app: app, market: availability['market'])
  end

  tv_data['seasons'].each do |season_data|
    season = tv.seasons.create!(season_data.slice('original_title', 'number', 'year', 'duration_in_seconds'))
    season_data['availabilities'].each do |availability|
      app = App.find_or_create_by!(name: availability['app'])
      season.availabilities.create!(app: app, market: availability['market'])
    end
  end

  tv_data['episodes'].each { |ep| tv.episodes.create!(ep) }
end

p 'channels'
data['channels'].each do |channel_data|
  channel = Channel.create!(channel_data.slice('original_title', 'year', 'duration_in_seconds'))
  channel_data['availabilities'].each do |availability|
    app = App.find_or_create_by!(name: availability['app'])
    channel.availabilities.create!(app: app, market: availability['market'])
  end

  channel_data['channel_programs'].each do |program_data|
    program = channel.channel_programs.create!(program_data.slice('original_title', 'year', 'duration_in_seconds'))
    program_data['schedule'].each { |sc| program.schedules.create!(sc) }
    program_data['availabilities'].each do |availability|
      app = App.find_or_create_by!(name: availability['app'])
      program.availabilities.create!(app: app, market: availability['market'])
    end
  end
end
