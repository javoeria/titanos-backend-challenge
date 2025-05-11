class ContentService
  def self.all(country, type = nil)
    availabilities = Availability.includes(:content).where(market: country)
    if type.present?
      if type == 'episodes'
        availabilities = availabilities.where(content_type: 'Season')
        seasons = availabilities.map(&:content).uniq
        return seasons.map { |s| s.tv_show.episodes.where(season_number: s.number) }.flatten
      else
        availabilities = availabilities.where(content_type: type.classify)
      end
    end

    availabilities.map(&:content).uniq
  end

  def self.get(type, id)
    model = type.classify.constantize
    content = model.find(id)
    json = content.as_json
    case type
    when 'tv_shows'
      json['seasons'] = content.seasons
      json['episodes'] = content.episodes
    when 'seasons'
      json['episodes'] = content.tv_show.episodes.where(season_number: content.number)
    when 'channels'
      json['channel_programs'] = content.channel_programs
    when 'channel_programs'
      json['watched_time'] = nil
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
