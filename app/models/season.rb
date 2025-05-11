# == Schema Information
#
# Table name: seasons
#
#  id                  :bigint           not null, primary key
#  original_title      :string(255)
#  number              :integer
#  year                :integer
#  duration_in_seconds :integer
#  tv_show_id          :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :availabilities, as: :content, dependent: :destroy

  validates :original_title, :number, presence: true

  def episodes
    tv_show.episodes.where(season_number: number)
  end
end
