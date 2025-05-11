class ContentService
  def self.all(country, type = nil)
    availabilities = Availability.includes(:content).where(market: country)
    if type.present?
      if type == 'episodes'
        availabilities = availabilities.where(content_type: 'Season')
        seasons = availabilities.map(&:content).uniq
        return seasons.map(&:episodes).flatten
      else
        availabilities = availabilities.where(content_type: type.classify)
      end
    end

    availabilities.map { |a| a.content.as_json.merge(type: a.content_type.underscore) }.uniq
  end

  def self.get(type, id, user_id = nil)
    model = type.classify.constantize
    content = model.find(id)
    json = content.as_json
    case type
    when 'tv_shows'
      json['seasons'] = content.seasons
      json['episodes'] = content.episodes
    when 'seasons'
      json['episodes'] = content.episodes
    when 'channels'
      json['channel_programs'] = content.channel_programs
    when 'channel_programs'
      if user_id.present?
        fav = FavoriteProgram.find_by(user_id: user_id, channel_program_id: id)
        json['watched_time'] = fav ? fav.watched_time : 0
      else
        json['watched_time'] = nil
      end
      json['schedule'] = content.schedules
    end

    json['availabilities'] = content.availabilities.map { |a| { app: a.app.name, market: a.market } } if type != 'episodes'
    json
  end

  def self.search(query)
    {
      apps: App.where('name LIKE ?', "%#{query}%"),
      movies: Movie.where('original_title LIKE ? OR year = ?', "%#{query}%", query),
      tv_shows: TvShow.where('original_title LIKE ? OR year = ?', "%#{query}%", query),
      seasons: Season.where('original_title LIKE ? OR year = ?', "%#{query}%", query),
      episodes: Episode.where('original_title LIKE ? OR year = ?', "%#{query}%", query),
      channels: Channel.where('original_title LIKE ? OR year = ?', "%#{query}%", query),
      channel_programs: ChannelProgram.where('original_title LIKE ? OR year = ?', "%#{query}%", query)
    }
  end
end
