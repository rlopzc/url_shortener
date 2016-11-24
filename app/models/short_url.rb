class ShortUrl < ApplicationRecord

  validates_uniqueness_of :converted
  validates_presence_of :original, :converted
  def self.generate
    loop do
      random = SecureRandom.base64.tr('+/=', 'Qrt')
      break random unless ShortUrl.exists?(converted: random)
    end
  end


end
