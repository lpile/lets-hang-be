require 'rails_helper'

describe 'Friendships Destroy', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it 'returns status code 204 when friendship request is declined' do
    # User 1 request to be friends with User 2
    user1.friend_request(user2)
    expect(Friendship.count).to eq(2)

    # User 2 is declining User 1 friend request
    delete "/api/v1/friendships/#{user1.id}?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(204)

    expect(Friendship.count).to eq(0)
  end

  it 'returns status code 204 when user removes a friend' do
    # User 1 request to be friends with User 2
    user1.friend_request(user2)
    # User 2 accepts friend request
    user2.accept_request(user1)
    expect(Friendship.count).to eq(2)

    # User 1 decides to remove User 2 as friend
    delete "/api/v1/friendships/#{user2.id}?api_key=#{user1.api_key}", headers: content_type

    expect(response).to have_http_status(204)

    expect(Friendship.count).to eq(0)
  end

  it 'returns json error message if user is found' do
    delete "/api/v1/friendships/#{user1.id}?api_key=lkj4!jhsnL", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if request user id is not found' do
    delete "/api/v1/friendships/5?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find requesting user')
  end
end
