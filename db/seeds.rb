require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

UserEvent.destroy_all
Friendship.destroy_all
User.destroy_all
Event.destroy_all

user1 = create(:user, first_name: 'Anneke', last_name: 'McGrady', email: 'anneke@email.com')
user2 = create(:user, first_name: 'Logan', last_name: 'Pile', email: 'logan@email.com')
user3 = create(:user, first_name: 'Ryan', last_name: 'Flachman', email: 'ryan@email.com')
user4 = create(:user, first_name: 'Kayla', last_name: 'Larson', email: 'kayla@email.com')
user5, user6, user7, user8, user9 = create_list(:user, 5)
event1 = create(:event, title: 'HAPPY HOUR', event_time: 'After school', creator: user2.first_name + ' ' + user2.last_name)
event2 = create(:event, title: 'Dinner', event_time: '6pm', creator: user2.first_name + ' ' + user2.last_name)
event3 = create(:event, title: 'Go for a bike ride', event_time: 'whenever', creator: user3.first_name + ' ' + user3.last_name)

user1.friend_request(user2)
user2.accept_request(user1)
user1.friend_request(user3)
user3.accept_request(user1)
user2.friend_request(user3)
user3.accept_request(user2)
user3.friend_request(user5)
user3.friend_request(user6)
user7.friend_request(user3)
user8.friend_request(user3)

# UserEvent.create!(user: user1, event: event1, status: :pending)
# UserEvent.create!(user: user1, event: event2, status: :pending)
# UserEvent.create!(user: user1, event: event3, status: :pending)
# user1 = User.create!(first_name: 'User', last_name: '1', phone_number: '1111111111', email: 'User1@email.com', password: 'password', password_confirmation: 'password')
# user2 = User.create!(first_name: 'User', last_name: '2', phone_number: '2222222222', email: 'User2@email.com', password: 'password', password_confirmation: 'password')
# user3 = User.create!(first_name: 'User', last_name: '3', phone_number: '3333333333', email: 'User3@email.com', password: 'password', password_confirmation: 'password')
# user4 = User.create!(first_name: 'User', last_name: '4', phone_number: '4444444444', email: 'User4@email.com', password: 'password', password_confirmation: 'password')
# user5 = User.create!(first_name: 'User', last_name: '5', phone_number: '5555555555', email: 'User5@email.com', password: 'password', password_confirmation: 'password')
# user6 = User.create!(first_name: 'User', last_name: '6', phone_number: '6666666666', email: 'User6@email.com', password: 'password', password_confirmation: 'password')
# user7 = User.create!(first_name: 'User', last_name: '7', phone_number: '7777777777', email: 'User7@email.com', password: 'password', password_confirmation: 'password')
# user8 = User.create!(first_name: 'User', last_name: '8', phone_number: '8888888888', email: 'User8@email.com', password: 'password', password_confirmation: 'password')
#
# # User 1 creates 3 events
# event1 = Event.create!(title: 'Event 1', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user1.first_name} #{user1.last_name}")
# event2 = Event.create!(title: 'Event 2', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user1.first_name} #{user1.last_name}")
# event3 = Event.create!(title: 'Event 3', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user1.first_name} #{user1.last_name}")
# # User 2 creates 2 events
# event4 = Event.create!(title: 'Event 4', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user2.first_name} #{user2.last_name}")
# event5 = Event.create!(title: 'Event 5', description: 'description', event_time: 'whenever', event_location: 'Denver, CO', creator: "#{user2.first_name} #{user2.last_name}")
#
# # User 1 is friends with Users 2,3,4
# # User 1 has pending friends of Users 5 and 6
# # User 1 is a requested friend from Users 7 and 8
# # User 8 has no accepted friends
# # User 8 has pending friends of Users 1,2,3
# # User 8 is a requested friend from Users 4,5,6
# user1.friend_request(user2)
# user2.accept_request(user1)
# user1.friend_request(user3)
# user3.accept_request(user1)
# user1.friend_request(user4)
# user4.accept_request(user1)
# user1.friend_request(user5)
# user1.friend_request(user6)
# user7.friend_request(user1)
# user8.friend_request(user1)
# user8.friend_request(user2)
# user8.friend_request(user3)
# user4.friend_request(user8)
# user5.friend_request(user8)
# user6.friend_request(user8)
#
# # Event 1 has users 1 and 2 attending, user 3 is pending, user 4 has declined
# # Event 2 only has user 1 attending
# # Event 3 has user 1 attending, user 3 is pending, user 5 has declined
# # Event 4 and 5 has only user 2 attending
# UserEvent.create!(user: user4, event: event1, status: :declined)
# UserEvent.create!(user: user1, event: event2, status: :accepted)
# UserEvent.create!(user: user1, event: event3, status: :accepted)
# UserEvent.create!(user: user3, event: event3, status: :pending)
# UserEvent.create!(user: user5, event: event3, status: :declined)
# UserEvent.create!(user: user2, event: event4, status: :accepted)
# UserEvent.create!(user: user2, event: event5, status: :accepted)

UserEvent.create!(user: user1, event: event1, status: :accepted)
UserEvent.create!(user: user2, event: event1, status: :accepted)
UserEvent.create!(user: user3, event: event1, status: :pending)
UserEvent.create!(user: user4, event: event1, status: :accepted)
UserEvent.create!(user: user5, event: event1, status: :pending)
UserEvent.create!(user: user6, event: event1, status: :pending)
UserEvent.create!(user: user1, event: event2, status: :accepted)
UserEvent.create!(user: user2, event: event2, status: :accepted)
UserEvent.create!(user: user3, event: event2, status: :pending)
UserEvent.create!(user: user4, event: event2, status: :accepted)
UserEvent.create!(user: user6, event: event2, status: :pending)
UserEvent.create!(user: user7, event: event2, status: :pending)
UserEvent.create!(user: user1, event: event3, status: :accepted)
UserEvent.create!(user: user2, event: event3, status: :accepted)
UserEvent.create!(user: user3, event: event3, status: :pending)
UserEvent.create!(user: user4, event: event3, status: :accepted)
UserEvent.create!(user: user7, event: event3, status: :pending)
UserEvent.create!(user: user8, event: event3, status: :pending)
