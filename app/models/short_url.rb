# == Schema Information
#
# Table name: short_urls
#
#  id         :integer          not null, primary key
#  original   :string
#  converted  :string
#  count      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id_id :integer
#
# Indexes
#
#  index_short_urls_on_user_id_id  (user_id_id)
#

class ShortUrl < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates_uniqueness_of :converted
  validates_presence_of :original, :converted
  
  def self.generate
    loop do
      random = SecureRandom.base64.tr('+/=', 'Qrt')
      break random unless ShortUrl.exists?(converted: random)
    end
  end


end
