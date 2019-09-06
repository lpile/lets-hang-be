require 'rails_helper'

describe 'User Events Index', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { create(:user) }

  it 'returns json array of user event objects' do
    event1, event2, event3 = create_list(:event, 3)

    UserEvent.create!(user: user1, event: event1)
    UserEvent.create!(user: user1, event: event2)
    UserEvent.create!(user: user1, event: event3)

    get "/api/v1/user/events?api_key=#{user1.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    # Checks the count of user's events
    expect(result["data"]["attributes"]["events"].count).to eq(3)
    # Checks the first event's keys
    expect(result["data"]["attributes"]["events"].first).to have_key('Title')
    expect(result["data"]["attributes"]["events"].first).to have_key('Description')
    expect(result["data"]["attributes"]["events"].first).to have_key('Time')
    expect(result["data"]["attributes"]["events"].first).to have_key('Creator')
    expect(result["data"]["attributes"]["events"].first).to have_key('Location')
    # Checks the last event's values
    expect(result["data"]["attributes"]["events"].last).to have_value(event3.title)
    expect(result["data"]["attributes"]["events"].last).to have_value(event3.description)
    expect(result["data"]["attributes"]["events"].last).to have_value(Time.at(event3.event_time).strftime('%I:%M%p %m/%d/%y'))
    expect(result["data"]["attributes"]["events"].last).to have_value(event3.creator)
    expect(result["data"]["attributes"]["events"].last).to have_value(event3.event_location)
  end

  it 'returns json empty array if user has no events' do
    get "/api/v1/user/events?api_key=#{user1.api_key}", headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result["data"]["attributes"]["events"].count).to eq(0)
  end

  it 'returns json error message if no user is found' do
    get '/api/v1/user/events?api_key=sk3?12kd!dAA', headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end
end
