require 'rails_helper'

describe 'Friendships Update', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it 'returns json response of requester and requestee' do
    # User 1 request to be friends with User 2
    user1.friend_request(user2)
    expect(Friendship.count).to eq(2)

    # User 2 accepts friend request
    patch "/api/v1/friendships/#{user1.id}?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(202)

    result = JSON.parse(response.body)

    user1_friendship = Friendship.first # Requester
    user2_friendship = Friendship.last # Requestee

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(user2_friendship.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('accept')
    expect(result['data']).to have_key('attributes')
    expect(result['data']['attributes']).to have_key('requester')
    expect(result['data']['attributes']).to have_key('requestee')
    # Checks response has correct data
    expect(result['data']['attributes']['requester']['id']).to eq(user1.id)
    expect(result['data']['attributes']['requester']['name']).to eq("#{user1.first_name} #{user1.last_name}")
    expect(result['data']['attributes']['requester']['status']).to eq(user1_friendship.status)
    expect(result['data']['attributes']['requestee']['id']).to eq(user2.id)
    expect(result['data']['attributes']['requestee']['name']).to eq("#{user2.first_name} #{user2.last_name}")
    expect(result['data']['attributes']['requestee']['status']).to eq(user2_friendship.status)
    # Checks if new friendship was successful added to Friendship table
    expect(user1_friendship.user_id).to eq(user1.id)
    expect(user1_friendship.friend_id).to eq(user2.id)
    expect(user1_friendship.status).to eq('accepted')
    expect(user2_friendship.user_id).to eq(user2.id)
    expect(user2_friendship.friend_id).to eq(user1.id)
    expect(user2_friendship.status).to eq('accepted')
  end

  it 'returns json error message if user is found' do
    patch "/api/v1/friendships/#{user1.id}?api_key=lkj4!jhsnL", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if requesting user id is not found' do
    patch "/api/v1/friendships/5?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find requesting user')
  end
end
