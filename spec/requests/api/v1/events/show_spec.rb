require 'rails_helper'

describe 'Events Show', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:event) { create(:event, creator: "#{user1.first_name} #{user1.last_name}") }

  it 'returns json information of one event' do
    UserEvent.create!(user: user1, event: event)
    UserEvent.create!(user: user2, event: event)
    UserEvent.create!(user: user3, event: event)

    get "/api/v1/events/#{event.id}?api_key=#{user1.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(event.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('event')
    expect(result['data']).to have_key('attributes')
    # Checks response has correct data
    expect(result['data']['attributes']['title']).to eq(event.title)
    expect(result['data']['attributes']['description']).to eq(event.description)
    expect(result['data']['attributes']['event_time']).to eq(Time.at(event.event_time).strftime('%I:%M%p %m/%d/%y'))
    expect(result['data']['attributes']['event_location']).to eq(event.event_location)
    expect(result['data']['attributes']['creator']).to eq(event.creator)
    expect(result['data']['attributes']['attendees'].count).to eq(3)
  end

  it 'returns json information of attendees of only creator if no other user attends event' do
    UserEvent.create!(user: user1, event: event)

    get "/api/v1/events/#{event.id}?api_key=#{user1.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks response has correct data
    expect(result['data']['attributes']['attendees'].count).to eq(1)
    expect(result['data']['attributes']['attendees'].first).to eq("#{user1.first_name} #{user1.last_name}")
  end

  it 'returns json error message if no user is found' do
    UserEvent.create!(user: user1, event: event)

    get "/api/v1/events/#{event.id}?api_key=s23!fsdWdsd4?2fds", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if no event is found' do
    UserEvent.create!(user: user1, event: event)

    get "/api/v1/events/1?api_key=#{user1.api_key}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find event')
  end

  it 'returns json error message if user tries to look into an event not associated with' do
    UserEvent.create!(user: user1, event: event)

    get "/api/v1/events/#{event.id}?api_key=#{user2.api_key}", headers: content_type

    expect(response).to have_http_status(401)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Unauthorized user')
  end
end
