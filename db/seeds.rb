require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

User.destroy_all
Event.destroy_all
UserEvent.destroy_all

user1, user2, user3 = create_list(:user, 3)

event1, event2, event3 = create_list(:event, 3, creator: user1.first_name + ' ' + user1.last_name)
event4, event5 = create_list(:event, 2, creator: user2.first_name + ' ' + user2.last_name)
event6 = create(:event, creator: user3.first_name + ' ' + user3.last_name)

UserEvent.create!(user: user1, event: event1)
UserEvent.create!(user: user1, event: event2)
UserEvent.create!(user: user1, event: event3)
UserEvent.create!(user: user2, event: event4)
UserEvent.create!(user: user2, event: event5)
UserEvent.create!(user: user3, event: event6)
