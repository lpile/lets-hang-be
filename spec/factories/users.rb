FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.safe_email }
    password { 'password' }
    phone_number { Faker::PhoneNumber.cell_phone }
    api_key { Faker::Crypto.md5 }
  end
end
