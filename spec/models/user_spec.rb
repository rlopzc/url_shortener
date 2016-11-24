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

require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:name)}
  it {should have_many(:short_urls)}
end
