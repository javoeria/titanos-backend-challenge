# == Schema Information
#
# Table name: schedules
#
#  id                 :bigint           not null, primary key
#  start_time         :datetime
#  end_time           :datetime
#  channel_program_id :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Schedule < ApplicationRecord
  belongs_to :channel_program

  validates :start_time, :end_time, presence: true
end
