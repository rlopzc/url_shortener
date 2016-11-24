# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :short_url do
    sequence(:original) { |n| "http://#{n}example.com" }
    converted {SecureRandom.base64}
  end
end
