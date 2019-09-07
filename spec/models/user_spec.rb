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

  describe 'instance methods' do

    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    describe 'friend_request(friend)' do
      it 'can add both relationships to friendships table with correct status' do
        expect(Friendship.count).to eq(0)

        user1.friend_request(user2)

        expect(Friendship.count).to eq(2)

        friendship_row1 = Friendship.first
        friendship_row2 = Friendship.last

        expect(friendship_row1.status).to eq('pending')
        expect(friendship_row2.status).to eq('requested')
      end

      it 'unable to add self as friend' do
        user1.friend_request(user1)

        expect(Friendship.count).to eq(0)
      end
    end
  end
end
