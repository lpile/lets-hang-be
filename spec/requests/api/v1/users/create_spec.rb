require 'rails_helper'

describe 'User Create', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { {'first_name': 'First Name', 'last_name': 'Last Name', 'phone_number': '3033033030', 'email': 'FirstLast@email.com', 'password': 'password', 'password_confirmation': 'password'} }
  let(:error_user) { {'last_name': 'Last Name', 'phone_number': '3033033030', 'email': 'FirstLast@email.com', 'password': 'password', 'password_confirmation': 'password'} }

  it 'returns json information of user when registering' do
    post '/api/v1/users', params: user.to_json, headers: content_type

    expect(response).to have_http_status(:created)

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
    expect(result['data']['attributes']['first_name']).to eq(user_output.first_name)
    expect(result['data']['attributes']['last_name']).to eq(user_output.last_name)
    expect(result['data']['attributes']['phone_number']).to eq(user_output.phone_number)
    expect(result['data']['attributes']['email']).to eq(user_output.email)
    expect(result['data']['attributes']['api_key']).to eq(user_output.api_key)
    # Checks if user was successful added to User table
    expect(user_output.first_name).to eq(user[:first_name])
    expect(user_output.last_name).to eq(user[:last_name])
    expect(user_output.phone_number).to eq(user[:phone_number])
    expect(user_output.email).to eq(user[:email])
  end

  it 'returns json error message if information is missing in the request' do
    post '/api/v1/users', params: error_user.to_json

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to register')
  end
end
