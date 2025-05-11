# == Schema Information
#
# Table name: episodes
#
#  id                  :bigint           not null, primary key
#  original_title      :string(255)
#  number              :integer
#  season_number       :integer
#  year                :integer
#  duration_in_seconds :integer
#  tv_show_id          :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Episode < ApplicationRecord
  belongs_to :tv_show

  validates :original_title, :number, :season_number, presence: true
end
