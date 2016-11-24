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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :short_url do
    sequence(:original) { |n| "http://#{n}example.com" }
    converted {SecureRandom.base64}
  end
end
