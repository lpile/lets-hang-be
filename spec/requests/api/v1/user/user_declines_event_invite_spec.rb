require 'rails_helper'

describe 'User Event Accept Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:event) { create(:event, creator: user1.first_name + ' ' + user1.last_name) }

  it 'returns json event object information' do
    UserEvent.create!(user: user1, event: event, status: :accepted)
    UserEvent.create!(user: user2, event: event, status: :pending)

    delete "/api/v1/user/event/#{event.id}?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(202)

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
    expect(result['data']['attributes']['invited'].count).to eq(0)
    expect(result['data']['attributes']['accepted'].count).to eq(1)
    expect(result['data']['attributes']['declined'].count).to eq(1)
    # Checks the accepted user's keys
    expect(result['data']['attributes']['accepted'].first).to have_key('id')
    expect(result['data']['attributes']['accepted'].first).to have_key('name')
    # Checks the accepted user's values
    expect(result['data']['attributes']['accepted'].last).to have_value(user1.id)
    expect(result['data']['attributes']['accepted'].last).to have_value(user1.first_name + ' ' + user1.last_name)
    # # Checks the declined user's keys
    expect(result['data']['attributes']['declined'].first).to have_key('id')
    expect(result['data']['attributes']['declined'].first).to have_key('name')
    # Checks the declined user's values
    expect(result['data']['attributes']['declined'].last).to have_value(user2.id)
    expect(result['data']['attributes']['declined'].last).to have_value(user2.first_name + ' ' + user2.last_name)
    # Checks if all users where invited to event was successfully added to UserEvent table
    expect(user_events.count).to eq(2)
    expect(user_events[0].user_id).to eq(user1.id)
    expect(user_events[1].user_id).to eq(user2.id)
    expect(user_events[0].event_id).to eq(event.id)
    expect(user_events[1].event_id).to eq(event.id)
    expect(user_events[0].status).to eq('accepted')
    expect(user_events[1].status).to eq('declined')
  end

  it 'returns json error message if user cannot be found' do
    delete "/api/v1/user/event/#{event.id}?api_key=fakeyfakebadAp1", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if event cannot be found' do
    delete "/api/v1/user/event/2A?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find event')
  end
end
