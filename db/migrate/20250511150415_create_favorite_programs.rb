class CreateFavoritePrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_programs do |t|
      t.integer :watched_time
      t.references :user
      t.references :channel_program

      t.timestamps
    end
  end
end
