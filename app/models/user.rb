# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_key         :string
#

class User < ApplicationRecord
  has_many :short_urls
  has_secure_password
  validates_presence_of :name
  validates_presence_of :password, :password_confirmation, on: :create
  validates_uniqueness_of :name

  before_create do |user|
    user.api_key = user.generate_api_key
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end
end
