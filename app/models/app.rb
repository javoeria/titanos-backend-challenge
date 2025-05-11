# == Schema Information
#
# Table name: apps
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class App < ApplicationRecord
  has_many :availabilities, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
