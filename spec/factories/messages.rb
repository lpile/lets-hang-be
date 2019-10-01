FactoryBot.define do
  factory :message do
    content { "MyString" }
    user { nil }
    event { nil }
  end
end
