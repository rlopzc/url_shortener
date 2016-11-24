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

require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  it {should validate_uniqueness_of(:converted)}
  it {should validate_presence_of(:original)}
  it {should validate_presence_of(:converted)}
  it {should belong_to(:user)}
end
