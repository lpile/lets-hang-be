require 'rails_helper'

describe 'Event Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:event) { {'title': 'Happy Hour', 'description': 'Meet after school at Brothers', 'event_time': '1600', 'event_location': 'Brothers', 'creator': 'Mike Will', 'attendees': []} }
  let(:error_event) { {'title': 'Happy Hour', 'event_time': '1600', 'event_location': 'Brothers', 'creator': 'Mike Will', 'attendees': []} }

  it 'returns json event object to user upon creating an event' do
    post '/api/v1/events', params: event.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(:created)

    result = JSON.parse(response.body)

    event_output = Event.last

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(event_output.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('event')
    expect(result['data']).to have_key('attributes')
    # Checks response has correct data
    expect(result['data']['attributes']['title']).to eq(event_output.first_name)
    expect(result['data']['attributes']['description']).to eq(event_output.last_name)
    expect(result['data']['attributes']['event_time']).to eq(event_output.phone_number)
    expect(result['data']['attributes']['event_location']).to eq(event_output.email)
    expect(result['data']['attributes']['creator']).to eq(event_output.api_key)
    # Checks if new event was successful added to Event table
    expect(event_output.title).to eq(event[:title])
    expect(event_output.description).to eq(event[:description])
    expect(event_output.event_time).to eq(event[:event_time])
    expect(event_output.event_location).to eq(event[:event_location])
    expect(event_output.creator).to eq(event[:creator])
  end

  it 'returns json error message if information is missing in the request' do
    post '/api/v1/events', params: error_event.to_json

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to create event')
  end
end
