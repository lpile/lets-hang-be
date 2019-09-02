User.destroy_all
Event.destroy_all

user = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.safe_email,
  password: Faker::Internet.password,
  phone_number: Faker::PhoneNumber.phone_number
)

3.times do
  Event.create(
    title: Faker::Beer.style,
    description: Faker::ChuckNorris.fact,
    event_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
    creator: user.first_name
  )
end
