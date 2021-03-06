require 'rails_helper'

describe 'Event Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { User.create!(first_name: 'First', last_name: 'Last', phone_number: '3033033030', email: 'test@email.com', password: 'password', password_confirmation: 'password') }
  let(:event) { {'title': 'Happy Hour', 'description': 'Meet after school at Brothers', 'event_time': 'whenever', 'event_location': 'Brothers'} }
  let(:error_event1) { {'title': 'Happy Hour', 'event_time': 'whenever', 'event_location': 'Brothers'} }
  let(:error_event2) { {'title': 'Happy Hour', 'description': 'Meet after school at Brothers', 'event_time': 'whenever', 'event_location': 'Brothers'} }

  it 'returns json event object upon creating an event' do
    post "/api/v1/events?api_key=#{user.api_key}", params: event.to_json, headers: content_type

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
    expect(result['data']['attributes']['title']).to eq(event_output.title)
    expect(result['data']['attributes']['description']).to eq(event_output.description)
    expect(result['data']['attributes']['event_time']).to eq('whenever')
    expect(result['data']['attributes']['event_location']).to eq(event_output.event_location)
    expect(result['data']['attributes']['creator']).to eq(event_output.creator)
    # Checks if new event was successful added to Event table
    expect(event_output.title).to eq(event[:title])
    expect(event_output.description).to eq(event[:description])
    expect(event_output.event_time).to eq('whenever')
    expect(event_output.event_location).to eq(event[:event_location])
    expect(event_output.creator).to eq("#{user.first_name} #{user.last_name}")
  end

  it 'returns json error message if information is missing in the request' do
    post "/api/v1/events?api_key=#{user.api_key}", params: error_event1.to_json, headers: content_type

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to create event')
  end

  it 'returns json error message if no user is found' do
    post '/api/v1/events?api_key=asd!4gs?kSD', params: error_event2.to_json, headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end
end
