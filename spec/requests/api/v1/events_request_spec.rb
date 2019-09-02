require 'rails_helper'

describe 'Event Index', type: :request do
  it 'returns json array of event objects' do
    get '/api/v1/events'

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result).to have_key('data')
    expect(result.first).to have_key('id')
    expect(result.first).to have_key('title')
    expect(result.first).to have_key('description')
    expect(result.first).to have_key('event_time')
    expect(result.first).to have_key('creator')
    expect(result.first).to have_key('active')
  end
end
