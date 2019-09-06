require 'rails_helper'

describe 'Event Index', type: :request do
  it 'returns json array of event objects' do
    event1, event2, event3 = create_list(:event, 3)
    content_type = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    get '/api/v1/events', headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data'].class).to be(Array)
    expect(result['data'].first).to have_key('id')
    expect(result['data'].first).to have_key('type')
    expect(result['data'].first).to have_key('attributes')
    # Checks the count of user's events
    expect(result['data'].count).to eq(3)
    # Checks the first event's keys
    expect(result['data'].first['attributes']).to have_key('title')
    expect(result['data'].first['attributes']).to have_key('description')
    expect(result['data'].first['attributes']).to have_key('event_time')
    expect(result['data'].first['attributes']).to have_key('creator')
    expect(result['data'].first['attributes']).to have_key('event_location')
    # Checks the last event's values
    expect(result['data'].last['attributes']).to have_value(event3.title)
    expect(result['data'].last['attributes']).to have_value(event3.description)
    expect(result['data'].last['attributes']).to have_value(Time.at(event3.event_time).strftime('%I:%M%p %m/%d/%y'))
    expect(result['data'].last['attributes']).to have_value(event3.creator)
    expect(result['data'].last['attributes']).to have_value(event3.event_location)
  end
end
