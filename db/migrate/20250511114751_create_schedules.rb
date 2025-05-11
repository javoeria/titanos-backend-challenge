class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :channel_program

      t.timestamps
    end
  end
end
