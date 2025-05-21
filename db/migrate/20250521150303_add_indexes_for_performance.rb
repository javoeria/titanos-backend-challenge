class AddIndexesForPerformance < ActiveRecord::Migration[7.1]
  def change
    add_index :availabilities, :market
    add_index :availabilities, [:market, :content_type]
    add_index :episodes, [:tv_show_id, :season_number]
    add_index :favorite_apps, [:user_id, :position]
    add_index :favorite_apps, [:user_id, :app_id], unique: true
    add_index :favorite_programs, [:user_id, :watched_time]
    add_index :favorite_programs, [:user_id, :channel_program_id], unique: true
  end
end
