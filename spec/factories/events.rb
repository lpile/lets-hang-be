FactoryBot.define do
  factory :event do
    title { Faker::Beer.style }
    description { Faker::ChuckNorris.fact }
    event_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short) }
    creator { Faker::Games::Pokemon.name }
  end
end
