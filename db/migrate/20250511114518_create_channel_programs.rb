class CreateChannelPrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :channel_programs do |t|
      t.string :original_title
      t.integer :year
      t.integer :duration_in_seconds
      t.references :channel

      t.timestamps
    end
  end
end
