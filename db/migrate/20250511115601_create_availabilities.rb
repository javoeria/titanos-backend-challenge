class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.string :market
      t.references :app
      t.references :content, polymorphic: true

      t.timestamps
    end
  end
end
