require 'rails_helper'

describe 'User Pending Friends Index', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }
  let(:friends) { create_list(:user, 3) }

  it 'returns json array of users who have been requested to be friends by current user' do
    # Current user requesting other users to be friend
    friends.map { |friend| user.friend_request(friend) }

    get "/api/v1/user/pending_friends?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(user.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('user')
    expect(result['data']).to have_key('attributes')
    expect(result['data']['attributes']).to have_key('pending_friends')
    expect(result['data']['attributes']['pending_friends'].class).to be(Array)
    # Checks the count of user's friends
    expect(result['data']['attributes']['pending_friends'].count).to eq(3)
    # Checks the first friend's keys
    expect(result['data']['attributes']['pending_friends'].first).to have_key('id')
    expect(result['data']['attributes']['pending_friends'].first).to have_key('Name')
    expect(result['data']['attributes']['pending_friends'].first).to have_key('Phone Number')
    expect(result['data']['attributes']['pending_friends'].first).to have_key('Email')
    # Checks the last friend's values
    expect(result['data']['attributes']['pending_friends'].last).to have_value(friends[2].id)
    expect(result['data']['attributes']['pending_friends'].last).to have_value(friends[2].first_name + ' ' + friends[2].last_name)
    expect(result['data']['attributes']['pending_friends'].last).to have_value(friends[2].phone_number)
    expect(result['data']['attributes']['pending_friends'].last).to have_value(friends[2].email)
  end

  it 'returns json empty array if user has no pending friends' do
    get "/api/v1/user/pending_friends?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result['data']['attributes']['pending_friends'].count).to eq(0)
  end

  it 'returns json error message if no user is found' do
    get '/api/v1/user/pending_friends?api_key=ask@5SAd!sk', headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end
end
