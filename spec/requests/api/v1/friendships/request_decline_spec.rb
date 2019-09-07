require 'rails_helper'

describe 'Friendships Request Destory', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:body) { {'api_key': "#{user2.api_key}"} }

  it 'returns json message that pending friend request was removed' do
    user1.friend_request(user2)

    expect(Friendship.count).to eq(2)

    delete "/api/v1/friendships/decline/#{user1.id}", params: body.to_json, headers: content_type

    expect(response).to have_http_status(202)

    result = JSON.parse(response.body)

    expect(result['message']).to eq('Pending friend request has been removed')
    expect(Friendship.count).to eq(0)
  end

  it 'returns json error message if user is found' do
    delete "/api/v1/friendships/decline/#{user1.id}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if request user id is not found' do
    delete '/api/v1/friendships/decline/5', params: body.to_json, headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find requesting user')
  end
end
