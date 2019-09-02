require 'rails_helper'

describe 'Event Index', type: :request do
  it 'returns json array of event objects' do
    create_list(:event, 3)

    get '/api/v1/events'

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
    expect(result.first).to have_key('id')
    expect(result.first).to have_key('title')
    expect(result.first).to have_key('description')
    expect(result.first).to have_key('event_time')
    expect(result.first).to have_key('creator')
    expect(result.last).to have_key('id')
    expect(result.last).to have_key('title')
    expect(result.last).to have_key('description')
    expect(result.last).to have_key('event_time')
    expect(result.last).to have_key('creator')
  end
end
