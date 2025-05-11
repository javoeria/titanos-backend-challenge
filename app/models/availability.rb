# == Schema Information
#
# Table name: availabilities
#
#  id           :bigint           not null, primary key
#  market       :string(255)
#  app_id       :bigint
#  content_type :string(255)
#  content_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Availability < ApplicationRecord
  belongs_to :app
  belongs_to :content, polymorphic: true

  validates :market, presence: true
end
