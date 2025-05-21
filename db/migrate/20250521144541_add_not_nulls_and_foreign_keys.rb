class AddNotNullsAndForeignKeys < ActiveRecord::Migration[7.1]
  def change
    change_column_null :seasons, :tv_show_id, false
    change_column_null :episodes, :tv_show_id, false
    change_column_null :channel_programs, :channel_id, false
    change_column_null :schedules, :channel_program_id, false
    change_column_null :availabilities, :app_id, false
    change_column_null :availabilities, :content_id, false
    change_column_null :availabilities, :content_type, false
    change_column_null :favorite_apps, :user_id, false
    change_column_null :favorite_apps, :app_id, false
    change_column_null :favorite_programs, :user_id, false
    change_column_null :favorite_programs, :channel_program_id, false

    add_foreign_key :seasons, :tv_shows
    add_foreign_key :episodes, :tv_shows
    add_foreign_key :channel_programs, :channels
    add_foreign_key :schedules, :channel_programs
    add_foreign_key :availabilities, :apps
    add_foreign_key :favorite_apps, :users
    add_foreign_key :favorite_apps, :apps
    add_foreign_key :favorite_programs, :users
    add_foreign_key :favorite_programs, :channel_programs
  end
end
