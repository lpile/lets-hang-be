require 'rails_helper'

describe 'Sessions Login', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { {'email': 'test@email.com', 'password': 'password'} }

  it 'returns json api key to user for logging in' do
    # Adds user to database
    User.create!(first_name: 'First', last_name: 'Last', phone_number: '3033033030', email: 'test@email.com', password: 'password', password_confirmation: 'password')

    post '/api/v1/sessions', params: user.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    result = JSON.parse(response.body)

    user_output = User.last

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(user_output.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('user')
    expect(result['data']).to have_key('attributes')
    # Checks response has correct data
    expect(result['data']['attributes']['api_key']).to eq(user_output.api_key)
  end

  it 'returns json error message if user fails to login' do
    post '/api/v1/sessions', params: user.to_json, headers: content_type

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to login')
  end
end
