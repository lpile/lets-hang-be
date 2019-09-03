require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

UserEvent.destroy_all
Friendship.destroy_all
User.destroy_all
Event.destroy_all

user1, user2, user3 = create_list(:user, 3)

# User 1 creates 3 events
event1, event2, event3 = create_list(:event, 3, creator: user1.first_name + ' ' + user1.last_name)
# User 2 creates 2 events
event4, event5 = create_list(:event, 2, creator: user2.first_name + ' ' + user2.last_name)
# User 3 creates 1 event
event6 = create(:event, creator: user3.first_name + ' ' + user3.last_name)

# User 1 creates event 1 and adds friends user 2 and user 3
UserEvent.create!(user: user1, event: event1)
UserEvent.create!(user: user2, event: event1)
UserEvent.create!(user: user3, event: event1)
# User 1 creates event 2 and adds friend user 2
UserEvent.create!(user: user1, event: event2)
UserEvent.create!(user: user2, event: event2)
# User 1 creates event 3 and adds friend user 3
UserEvent.create!(user: user1, event: event3)
UserEvent.create!(user: user3, event: event3)
# User 2 creates event 4 and adds no friends
UserEvent.create!(user: user2, event: event4)
# User 2 creates event 5 and adds friend user 1
UserEvent.create!(user: user2, event: event5)
UserEvent.create!(user: user1, event: event5)
# User 3 creates event 6 and adds friend user 1
UserEvent.create!(user: user3, event: event6)
UserEvent.create!(user: user1, event: event6)

# User 1 is friends with user 2 and user 3
Friendship.create!(user: user1, friend: user2)
Friendship.create!(user: user1, friend: user3)
# User 2 is reciprocal friends to user 1
Friendship.create!(user: user2, friend: user1)
# User 3 is reciprocal friends to user 1
Friendship.create!(user: user3, friend: user1)
