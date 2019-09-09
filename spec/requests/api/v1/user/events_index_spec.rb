require 'rails_helper'

describe 'User Events Index', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }

  it 'returns json array of user event objects' do
    event1, event2, event3 = create_list(:event, 3)

    UserEvent.create!(user: user, event: event1)
    UserEvent.create!(user: user, event: event2)
    UserEvent.create!(user: user, event: event3)

    get "/api/v1/user/events?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(user.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('user')
    expect(result['data']).to have_key('attributes')
    expect(result['data']['attributes']).to have_key('events')
    expect(result['data']['attributes']['events'].class).to be(Array)
    # Checks the count of user's events
    expect(result['data']['attributes']['events'].count).to eq(3)
    # Checks the first event's keys
    expect(result['data']['attributes']['events'].first).to have_key('title')
    expect(result['data']['attributes']['events'].first).to have_key('description')
    expect(result['data']['attributes']['events'].first).to have_key('event_time')
    expect(result['data']['attributes']['events'].first).to have_key('creator')
    expect(result['data']['attributes']['events'].first).to have_key('event_location')
    # Checks the last event's values
    expect(result['data']['attributes']['events'].last).to have_value(event3.title)
    expect(result['data']['attributes']['events'].last).to have_value(event3.description)
    expect(result['data']['attributes']['events'].last).to have_value('whenever')
    expect(result['data']['attributes']['events'].last).to have_value(event3.creator)
    expect(result['data']['attributes']['events'].last).to have_value(event3.event_location)
  end

  it 'returns json empty array if user has no events' do
    get "/api/v1/user/events?api_key=#{user.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result['data']['attributes']['events'].count).to eq(0)
  end

  it 'returns json error message if no user is found' do
    get '/api/v1/user/events?api_key=sk3?12kd!dAA', headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end
end
