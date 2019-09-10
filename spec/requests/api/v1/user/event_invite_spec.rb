require 'rails_helper'

describe 'Event Invite Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }
  let(:friends) { create_list(:user, 3) }
  let(:event) { create(:event, creator: user.first_name + ' ' + user.last_name) }

  it 'returns json event object information' do
    body = {'friend_ids': [friends[0].id, friends[1].id, friends[2].id]}

    post "/api/v1/user/event/#{event.id}?api_key=#{user.api_key}", params: body.to_json, headers: content_type

    expect(response).to have_http_status(:created)

    result = JSON.parse(response.body)

    user_events = UserEvent.all
    event_output= Event.find_by(id: event.id)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(event_output.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('event')
    expect(result['data']).to have_key('attributes')
    expect(result['data']['attributes']).to have_key('invited')
    expect(result['data']['attributes']).to have_key('accepted')
    expect(result['data']['attributes']).to have_key('declined')
    expect(result['data']['attributes']['invited'].class).to be(Array)
    expect(result['data']['attributes']['accepted'].class).to be(Array)
    expect(result['data']['attributes']['declined'].class).to be(Array)
    # Checks the count of event's user status
    expect(result['data']['attributes']['invited'].count).to eq(3)
    expect(result['data']['attributes']['accepted'].count).to eq(0)
    expect(result['data']['attributes']['declined'].count).to eq(0)
    # Checks the first invited user's keys
    expect(result['data']['attributes']['invited'].first).to have_key('id')
    expect(result['data']['attributes']['invited'].first).to have_key('Name')
    # Checks the last invited user's values
    expect(result['data']['attributes']['invited'].last).to have_value(friends[2].id)
    expect(result['data']['attributes']['invited'].last).to have_value(friends[2].first_name + ' ' + friends[2].last_name)
    # Checks if all users where invited to event was successfully added to UserEvent table
    expect(user_events.count).to eq(3)
    expect(user_events[0].user_id).to eq(friends[0].id)
    expect(user_events[2].user_id).to eq(friends[2].id)
    expect(user_events[0].event_id).to eq(event.id)
    expect(user_events[2].event_id).to eq(event.id)
    expect(user_events[0].status).to eq('pending')
    expect(user_events[2].status).to eq('pending')
  end

  it 'returns json error message if user cannot be found' do
    post "/api/v1/user/event/#{event.id}?api_key=fakeyfakebadAp1", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if event cannot be found' do
    post "/api/v1/user/event/2A?api_key=#{user.api_key}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find event')
  end
end
