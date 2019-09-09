require 'rails_helper'

describe 'User Friends Index', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }
  let(:friends) { create_list(:user, 4) }
  let(:requested) { create_list(:user, 3) }
  let(:pending) { create_list(:user, 2) }

  it 'returns json array of user friend objects' do
    friends.map { |friend| Friendship.create!(user: user, friend: friend, status: :accepted) }
    # Other users are requesting the current user to be friends
    requested.map { |request| request.friend_request(user) }
    # Current user requesting other users to be friend
    pending.map { |pending| user.friend_request(pending) }

    get "/api/v1/user/friends?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(user.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('user')
    expect(result['data']).to have_key('attributes')
    expect(result['data']['attributes']).to have_key('accepted_friends')
    expect(result['data']['attributes']).to have_key('requested_friends')
    expect(result['data']['attributes']).to have_key('pending_friends')
    expect(result['data']['attributes']['accepted_friends'].class).to be(Array)
    expect(result['data']['attributes']['requested_friends'].class).to be(Array)
    expect(result['data']['attributes']['pending_friends'].class).to be(Array)
    # Checks the count of user's friends
    expect(result['data']['attributes']['accepted_friends'].count).to eq(4)
    expect(result['data']['attributes']['requested_friends'].count).to eq(3)
    expect(result['data']['attributes']['pending_friends'].count).to eq(2)
    # Checks the first accepted friend's keys
    expect(result['data']['attributes']['accepted_friends'].first).to have_key('id')
    expect(result['data']['attributes']['accepted_friends'].first).to have_key('name')
    expect(result['data']['attributes']['accepted_friends'].first).to have_key('phone_number')
    expect(result['data']['attributes']['accepted_friends'].first).to have_key('email')
    # Checks the last accepted friend's values
    expect(result['data']['attributes']['accepted_friends'].last).to have_value(friends[3].id)
    expect(result['data']['attributes']['accepted_friends'].last).to have_value(friends[3].first_name + ' ' + friends[3].last_name)
    expect(result['data']['attributes']['accepted_friends'].last).to have_value(friends[3].phone_number)
    expect(result['data']['attributes']['accepted_friends'].last).to have_value(friends[3].email)
    # Checks the first requested friend's keys
    expect(result['data']['attributes']['requested_friends'].first).to have_key('id')
    expect(result['data']['attributes']['requested_friends'].first).to have_key('name')
    expect(result['data']['attributes']['requested_friends'].first).to have_key('phone_number')
    expect(result['data']['attributes']['requested_friends'].first).to have_key('email')
    # Checks the last requested friend's values
    expect(result['data']['attributes']['requested_friends'].last).to have_value(requested[2].id)
    expect(result['data']['attributes']['requested_friends'].last).to have_value(requested[2].first_name + ' ' + requested[2].last_name)
    expect(result['data']['attributes']['requested_friends'].last).to have_value(requested[2].phone_number)
    expect(result['data']['attributes']['requested_friends'].last).to have_value(requested[2].email)
    # Checks the first pending friend's keys
    expect(result['data']['attributes']['pending_friends'].first).to have_key('id')
    expect(result['data']['attributes']['pending_friends'].first).to have_key('name')
    expect(result['data']['attributes']['pending_friends'].first).to have_key('phone_number')
    expect(result['data']['attributes']['pending_friends'].first).to have_key('email')
    # Checks the last pending friend's values
    expect(result['data']['attributes']['pending_friends'].last).to have_value(pending[1].id)
    expect(result['data']['attributes']['pending_friends'].last).to have_value(pending[1].first_name + ' ' + pending[1].last_name)
    expect(result['data']['attributes']['pending_friends'].last).to have_value(pending[1].phone_number)
    expect(result['data']['attributes']['pending_friends'].last).to have_value(pending[1].email)
  end

  it 'returns json empty array if user has no accepted friends' do
    # Other users are requesting the current user to be friends
    requested.map { |request| request.friend_request(user) }
    # Current user requesting other users to be friend
    pending.map { |pending| user.friend_request(pending) }

    get "/api/v1/user/friends?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result['data']['attributes']['accepted_friends'].count).to eq(0)
    expect(result['data']['attributes']['requested_friends'].count).to eq(3)
    expect(result['data']['attributes']['pending_friends'].count).to eq(2)
  end

  it 'returns json empty array if user has no requested friends' do
    friends.map { |friend| Friendship.create!(user: user, friend: friend, status: :accepted) }
    # Other users are requesting the current user to be friends
    pending.map { |pending| user.friend_request(pending) }

    get "/api/v1/user/friends?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result['data']['attributes']['accepted_friends'].count).to eq(4)
    expect(result['data']['attributes']['requested_friends'].count).to eq(0)
    expect(result['data']['attributes']['pending_friends'].count).to eq(2)
  end

  it 'returns json empty array if user has no pending friends' do
    friends.map { |friend| Friendship.create!(user: user, friend: friend, status: :accepted) }
    # Other users are requesting the current user to be friends
    requested.map { |request| request.friend_request(user) }

    get "/api/v1/user/friends?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result['data']['attributes']['accepted_friends'].count).to eq(4)
    expect(result['data']['attributes']['requested_friends'].count).to eq(3)
    expect(result['data']['attributes']['pending_friends'].count).to eq(0)
  end

  it 'returns json error message if no user is found' do
    get '/api/v1/user/friends?api_key=ask@5SAd!sk', headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end
end
