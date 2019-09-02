require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:event_time) }
    it { should validate_presence_of(:creator) }
  end
  
  describe 'relationships' do
    it { should have_many(:users).through(:user_events) }
  end
end
