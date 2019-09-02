FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    password_digest { Faker::Internet.password }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
