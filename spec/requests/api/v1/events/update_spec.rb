require 'rails_helper'

describe 'Event Update', type: :request do
  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { User.create!(first_name: 'First', last_name: 'Last', phone_number: '3033033030', email: 'test@email.com', password: 'password', password_confirmation: 'password') }
  let(:event) { create(:event, creator: "#{user1.first_name} #{user1.last_name}") }
  
  it 'returns json updated event information' do
    body = {'title': 'Update', 'description': 'Update', 'event_time': DateTime.current, 'event_location': 'Update', 'api_key': "#{user1.api_key}"}
    id = event.id
    patch "/api/v1/events/#{id}/edit", params: body.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(202)

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
    expect(result['data']['attributes']['event_time']).to eq(Time.at(event_output.event_time).strftime('%I:%M%p %m/%d/%y'))
    expect(result['data']['attributes']['event_location']).to eq(event_output.event_location)
    expect(result['data']['attributes']['creator']).to eq(event_output.creator)
    # Checks if event was successful updated to Event table
    expect(event_output.title).to_not eq(event[:title])
    expect(event_output.description).to_not eq(event[:description])
    expect(Time.at(event_output.event_time).strftime('%I:%M%p %m/%d/%y')).to_not eq(Time.at(event[:event_time]).strftime('%I:%M%p %m/%d/%y'))
    expect(event_output.event_location).to_not eq(event[:event_location])
  end

  it 'returns json error message if user cannot be found' do
    # binding.pry
    body = {'title': 'Update', 'description': 'Update', 'event_time': DateTime.current, 'event_location': 'Update', 'api_key': "LKhd345!?ksdET"}
    id = event.id

    patch "/api/v1/events/#{id}/edit", params: body.to_json, headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if event cannot be updated' do
    # User trying to update an event they did not create
    another_user = create(:user, first_name: 'Someone', last_name: 'Else') 
    event2 = create(:event, creator: "#{another_user.first_name} #{another_user.last_name}") 
    id = event2.id

    body = {'title': 'Update', 'description': 'Update', 'event_time': DateTime.current, 'event_location': 'Update', 'api_key': "#{user1.api_key}"}

    patch "/api/v1/events/#{id}/edit", params: body.to_json, headers: content_type

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to update event')
  end

  it 'returns json updated event information with only one updated attribute' do
    body = {'title': 'Update', 'api_key': "#{user1.api_key}"}
    id = event.id

    patch "/api/v1/events/#{id}/edit", params: body.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(202)

    result = JSON.parse(response.body)

    event_output = Event.last

    # Checks if user was successful updated to User table
    
    expect(event_output.title).to_not eq(event[:title])
    expect(event_output.description).to eq(event[:description])
    expect(Time.at(event_output.event_time).strftime('%I:%M%p %m/%d/%y')).to eq(Time.at(event[:event_time]).strftime('%I:%M%p %m/%d/%y'))
    expect(event_output.event_location).to eq(event[:event_location])
  end


end