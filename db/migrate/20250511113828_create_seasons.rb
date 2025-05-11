class CreateSeasons < ActiveRecord::Migration[7.1]
  def change
    create_table :seasons do |t|
      t.string :original_title
      t.integer :number
      t.integer :year
      t.integer :duration_in_seconds
      t.references :tv_show

      t.timestamps
    end
  end
end
