require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  it {should validate_uniqueness_of(:converted)}
  it {should validate_presence_of(:original)}
  it {should validate_presence_of(:converted)}
end
