FactoryBot.define do
  factory :event do
    title { Faker::TvShows::MichaelScott.quote }
    description { Faker::ChuckNorris.fact }
    event_time { 'whenever' }
    creator { Faker::TvShows::GameOfThrones.character }
    event_location { Faker::TvShows::GameOfThrones.city }
  end
end
