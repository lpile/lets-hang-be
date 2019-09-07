require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:phone_number) }
  end

  describe 'relationships' do
    it { should have_many(:events).through(:user_events) }
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:requested_friends).through(:friendships) }
    it { should have_many(:pending_friends).through(:friendships) }
    it { should have_many(:blocked_friends).through(:friendships) }
  end
end
