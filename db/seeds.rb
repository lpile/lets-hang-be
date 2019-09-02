User.destroy_all
Event.destroy_all
UserEvent.destroy_all

user1 = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.safe_email,
  password: Faker::Internet.password,
  phone_number: Faker::PhoneNumber.phone_number
)

event1 = Event.create!(
  title: Faker::Beer.style,
  description: Faker::ChuckNorris.fact,
  event_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
  creator: user1.first_name
)

event2 = Event.create!(
  title: Faker::Beer.style,
  description: Faker::ChuckNorris.fact,
  event_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
  creator: user1.first_name
)

event3 = Event.create!(
  title: Faker::Beer.style,
  description: Faker::ChuckNorris.fact,
  event_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
  creator: user1.first_name
)


UserEvent.create!(user: user1, event: event1)
UserEvent.create!(user: user1, event: event2)
UserEvent.create!(user: user1, event: event3)


