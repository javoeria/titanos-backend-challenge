# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :favorite_apps, dependent: :destroy
  has_many :favorite_programs, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
