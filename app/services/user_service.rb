class UserService
  def self.favorite_programs(user_id)
    favs = FavoriteProgram.includes(:channel_program).where(user_id: user_id).order(watched_time: :desc)
    favs.map { |fav| fav.channel_program.as_json.merge(watched_time: fav.watched_time) }
  end

  def self.favorite_apps(user_id)
    favs = FavoriteApp.includes(:app).where(user_id: user_id).order(:position)
    favs.map { |fav| fav.app.as_json.merge(position: fav.position) }
  end

  def self.create_favorite_app(user_id, app_id, position)
    FavoriteApp.create!(user_id: user_id, app_id: app_id, position: position)
  end
end
