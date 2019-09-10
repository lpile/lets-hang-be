require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

UserEvent.destroy_all
Friendship.destroy_all
User.destroy_all
Event.destroy_all

user1 = User.create!(first_name: 'User', last_name: '1', phone_number: '1111111111', email: 'User1@email.com', password: 'password', password_confirmation: 'password')
user2 = User.create!(first_name: 'User', last_name: '2', phone_number: '2222222222', email: 'User2@email.com', password: 'password', password_confirmation: 'password')
user3 = User.create!(first_name: 'User', last_name: '3', phone_number: '3333333333', email: 'User3@email.com', password: 'password', password_confirmation: 'password')
user4 = User.create!(first_name: 'User', last_name: '4', phone_number: '4444444444', email: 'User4@email.com', password: 'password', password_confirmation: 'password')
user5 = User.create!(first_name: 'User', last_name: '5', phone_number: '5555555555', email: 'User5@email.com', password: 'password', password_confirmation: 'password')
user6 = User.create!(first_name: 'User', last_name: '6', phone_number: '6666666666', email: 'User6@email.com', password: 'password', password_confirmation: 'password')
user7 = User.create!(first_name: 'User', last_name: '7', phone_number: '7777777777', email: 'User7@email.com', password: 'password', password_confirmation: 'password')
user8 = User.create!(first_name: 'User', last_name: '8', phone_number: '8888888888', email: 'User8@email.com', password: 'password', password_confirmation: 'password')

# User 1 creates 3 events
event1 = Event.create!(title: 'Event 1', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user1.first_name} #{user1.last_name}")
event2 = Event.create!(title: 'Event 2', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user1.first_name} #{user1.last_name}")
event3 = Event.create!(title: 'Event 3', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user1.first_name} #{user1.last_name}")
# User 2 creates 2 events
event4 = Event.create!(title: 'Event 4', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user2.first_name} #{user2.last_name}")
event5 = Event.create!(title: 'Event 5', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user2.first_name} #{user2.last_name}")

# User 1 is friends with Users 2,3,4
# User 1 has pending friends of Users 5 and 6
# User 1 is a requested friend from Users 7 and 8
# User 8 has no accepted friends
# User 8 has pending friends of Users 1,2,3
# User 8 is a requested friend from Users 4,5,6
user1.friend_request(user2)
user2.accept_request(user1)
user1.friend_request(user3)
user3.accept_request(user1)
user1.friend_request(user4)
user4.accept_request(user1)
user1.friend_request(user5)
user1.friend_request(user6)
user7.friend_request(user1)
user8.friend_request(user1)
user8.friend_request(user2)
user8.friend_request(user3)
user4.friend_request(user8)
user5.friend_request(user8)
user6.friend_request(user8)

# Event 1 has users 1 through 5 attending
# Event 2 only has user 1 attending
# Event 3 has users 1, 3, 5 attending
# Event 4 has users 2 through 6 attending
# Event 5 only has user 2 attending
UserEvent.create!(user: user1, event: event1, status: :accepted)
UserEvent.create!(user: user2, event: event1, status: :accepted)
UserEvent.create!(user: user3, event: event1, status: :accepted)
UserEvent.create!(user: user4, event: event1, status: :accepted)
UserEvent.create!(user: user5, event: event1, status: :accepted)
UserEvent.create!(user: user1, event: event2, status: :accepted)
UserEvent.create!(user: user1, event: event3, status: :accepted)
UserEvent.create!(user: user3, event: event3, status: :accepted)
UserEvent.create!(user: user5, event: event3, status: :accepted)
UserEvent.create!(user: user2, event: event4, status: :accepted)
UserEvent.create!(user: user3, event: event4, status: :accepted)
UserEvent.create!(user: user4, event: event4, status: :accepted)
UserEvent.create!(user: user5, event: event4, status: :accepted)
UserEvent.create!(user: user6, event: event4, status: :accepted)
UserEvent.create!(user: user2, event: event5, status: :accepted)
