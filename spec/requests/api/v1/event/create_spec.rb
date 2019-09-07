require 'rails_helper'

describe 'Event Invite Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { User.create!(first_name: 'First', last_name: 'Last', phone_number: '3033033030', email: 'test@email.com', password: 'password', password_confirmation: 'password') }
  let(:friend) { User.create!(first_name: 'New', last_name: 'Friend', phone_number: '3033033031', email: 'test2@email.com', password: 'password2', password_confirmation: 'password2') }
  let(:event) { Event.create!( title: 'Happy Hour', description: 'Meet after school at Brothers', event_time: DateTime.current, event_location: 'Brothers', creator: "#{user.first_name} #{user.last_name}") } 
  let(:user_event) { {'api_key': "#{user.api_key}" } }

  it 'returns json messsge upon adding User Event with status of pending' do
    post "/api/v1/event/invite/#{friend.id}?event_id=#{event.id}", params: user_event.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(:created)

    result = JSON.parse(response.body)

    user_event_output = UserEvent.last

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    # expect(result['data']['id']).to eq(event_output.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('user')
    expect(result['data']).to have_key('attributes')
    # Checks response has correct data
    # expect(result['data']['attributes']['user_id']).to eq(event_output.user_id)
    # expect(result['data']['attributes']['event_id']).to eq(event_output.event_id)
    # Checks if new event was successful added to Event table
    # expect(user_event_output.user_id).to eq(user_event[:user_id])
    # expect(user_event_output.event_id).to eq(user_event[:event_id])
  end

  it 'returns json error message if user cannot be found' do
    body = { "api_key": "Fakeapikey666" }
    post "/api/v1/event/invite/#{friend.id}?#{event.id}", params: body.to_json, headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

end