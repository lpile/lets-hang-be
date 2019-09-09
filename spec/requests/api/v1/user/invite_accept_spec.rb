require 'rails_helper'

describe 'Event Accept Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }
  let(:friends) { create_list(:user, 3) }
  let(:event) { create(:event, creator: user.first_name + ' ' + user.last_name) }
  
  it 'returns json messsge upon adding User Event with status of pending' do
  
    patch "/api/v1/user/event/#{event.id}?api_key=#{user.api_key}", params: body.to_json, headers: content_type
    
    expect(response).to be_successful
    expect(response).to have_http_status(:created)

    result = JSON.parse(response.body)

    user_event_output = UserEvent.last
    event_output= Event.find_by(id: event.id)

    # Checks response JSON API 1.0 Compliant
   
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(event_output.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('event')
    expect(result['data']).to have_key('attributes')
    # Checks response has correct data

    expect(result['data']['attributes']['invited'][0]).to eq({"id": friend[0].id,"name": freinds[0].first_name + ' ' + friends[0].last_name})
    expect(result['data']['attributes']['id']).to eq(event_output.id)
    
    # Checks if new event was successful added to UserEvent table
 
    expect(user_event_output.user_id).to eq(friends[2].id)
    expect(user_event_output.event_id).to eq(event.id)
    expect(user_event_output.status).to eq("pending")
  end

  it 'returns json error message if user cannot be found' do
    post "/api/v1/user/event/#{event.id}?api_key=fakeyfakebadAp1", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if adding User Events records fails' do
    post "/api/v1/user/event/#{event.id}?api_key=#{user.api_key}", headers: content_type

    body = {friend_ids: ['2A', '3B' , '4C']}

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to invite')
  end


  it 'returns json error message if event cannot be found' do
    post "/api/v1/user/event/2A?api_key=#{user.api_key}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find friend')
  end

end