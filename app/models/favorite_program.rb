# == Schema Information
#
# Table name: favorite_programs
#
#  id                 :bigint           not null, primary key
#  watched_time       :integer
#  user_id            :bigint
#  channel_program_id :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class FavoriteProgram < ApplicationRecord
  belongs_to :user
  belongs_to :channel_program

  validates :channel_program_id, uniqueness: { scope: :user_id }
end
