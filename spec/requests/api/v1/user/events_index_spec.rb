require 'rails_helper'

describe 'User Events Index', type: :request do
  it 'returns json array of user event objects' do
    event1, event2, event3 = create_list(:event, 3)
    user1 = create(:user)

    UserEvent.create!(user: user1, event: event1)
    UserEvent.create!(user: user1, event: event2)
    UserEvent.create!(user: user1, event: event3)

    content_type= {'Content-Type': 'application/json', 'Accept': 'application/json'}

    get "/api/v1/user/events?api_key=#{user1.api_key}", headers: content_type
    
    expect(response).to be_successful

    result = JSON.parse(response.body)
    # binding.pry
    expect(result["data"]["attributes"]["events"].count).to eq(3)
    expect(result["data"]["attributes"]["events"].first).to have_key('Title')
    expect(result["data"]["attributes"]["events"].first).to have_key('Description')
    expect(result["data"]["attributes"]["events"].first).to have_key('Time')
    expect(result["data"]["attributes"]["events"].first).to have_key('Creator')
    expect(result["data"]["attributes"]["events"].first).to have_key('Location')
    expect(result["data"]["attributes"]["events"].last).to have_key('Title')
    expect(result["data"]["attributes"]["events"].last).to have_key('Description')
    expect(result["data"]["attributes"]["events"].last).to have_key('Time')
    expect(result["data"]["attributes"]["events"].last).to have_key('Creator')
    expect(result["data"]["attributes"]["events"].last).to have_key('Location')
  end
end