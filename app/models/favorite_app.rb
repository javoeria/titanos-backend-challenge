# == Schema Information
#
# Table name: favorite_apps
#
#  id         :bigint           not null, primary key
#  position   :integer
#  user_id    :bigint
#  app_id     :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FavoriteApp < ApplicationRecord
  belongs_to :user
  belongs_to :app

  validates :position, uniqueness: { scope: :user_id }
  validates :app_id, uniqueness: { scope: :user_id }
end
