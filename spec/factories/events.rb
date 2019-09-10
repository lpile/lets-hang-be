FactoryBot.define do
  factory :event do
    title { Faker::Beer.style }
    description { Faker::ChuckNorris.fact }
    event_time { 'whenever' }
    creator { Faker::Games::Pokemon.name }
    event_location { Faker::Beer.name }
  end
end
