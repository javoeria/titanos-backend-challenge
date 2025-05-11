# == Schema Information
#
# Table name: channel_programs
#
#  id                  :bigint           not null, primary key
#  original_title      :string(255)
#  year                :integer
#  duration_in_seconds :integer
#  channel_id          :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class ChannelProgram < ApplicationRecord
  belongs_to :channel
  has_many :schedules, dependent: :destroy
  has_many :availabilities, as: :content, dependent: :destroy

  validates :original_title, presence: true
end
