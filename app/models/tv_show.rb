# == Schema Information
#
# Table name: tv_shows
#
#  id                  :bigint           not null, primary key
#  original_title      :string(255)
#  year                :integer
#  duration_in_seconds :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class TvShow < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :availabilities, as: :content, dependent: :destroy

  validates :original_title, presence: true
end
