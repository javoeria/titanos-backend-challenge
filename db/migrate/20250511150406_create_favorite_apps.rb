class CreateFavoriteApps < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_apps do |t|
      t.integer :position
      t.references :user
      t.references :app

      t.timestamps
    end
  end
end
