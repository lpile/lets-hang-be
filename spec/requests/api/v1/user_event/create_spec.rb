require 'rails_helper'

describe 'User Event Invite Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { User.create!(first_name: 'First', last_name: 'Last', phone_number: '3033033030', email: 'test@email.com', password: 'password', password_confirmation: 'password') }
  let(:friend) { User.create!(first_name: 'New', last_name: 'Friend', phone_number: '3033033031', email: 'test2@email.com', password: 'password2', password_confirmation: 'password2') }
  let(:event) { Event.create!( title: 'Happy Hour', description: 'Meet after school at Brothers', event_time: DateTime.current, event_location: 'Brothers', creator: "#{user.first_name} #{user.last_name}") } 
  
  it 'returns json messsge upon adding User Event with status of pending' do
    post "/api/v1/user_events?api_key=#{user.api_key}&friend_id=#{friend.id}&event_id=#{event.id}", headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(:created)

    result = JSON.parse(response.body)

    user_event_output = UserEvent.last

    # Checks response JSON API 1.0 Compliant
   
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(user_event_output.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('user_event')
    expect(result['data']).to have_key('attributes')
    # Checks response has correct data
    expect(result['data']['attributes']['user_id']).to eq(user_event_output.user_id)
    expect(result['data']['attributes']['event_id']).to eq(user_event_output.event_id)
    
    # Checks if new event was successful added to Event table
 
    expect(user_event_output.user_id).to eq(friend.id)
    expect(user_event_output.event_id).to eq(event.id)
    expect(user_event_output.status).to eq("pending")
  end

  it 'returns json error message if user cannot be found' do
    post "/api/v1/user_events?api_key=fakeyfakeap1key&friend_id=#{friend.id}&event_id=#{event.id}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if event cannot be found' do
    post "/api/v1/user_events?api_key=#{user.api_key}&friend_id=#{friend.id}&event_id=2", headers: content_type

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to invite friend')
  end

end