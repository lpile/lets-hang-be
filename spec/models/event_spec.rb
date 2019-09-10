require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:event_time) }
    it { should validate_presence_of(:creator) }
    it { should validate_presence_of(:event_location) }
  end

  describe 'relationships' do
    it { should have_many(:user_events) }
    it { should have_many(:accepts).through(:user_events) }
    it { should have_many(:pendings).through(:user_events) }
    it { should have_many(:declines).through(:user_events) }
  end
end
