require 'rails_helper'

describe 'User Update', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }

  it 'returns json updated user information' do
    body = {'first_name': 'Update', 'last_name': 'Update', 'phone_number': '9999999999', 'email': 'update@email.com'}

    patch "/api/v1/users/#{user.id}?api_key=#{user.api_key}", params: body.to_json, headers: content_type

    expect(response).to have_http_status(202)

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
    # Checks if user was successful updated to User table
    expect(user_output.first_name).to_not eq(user[:first_name])
    expect(user_output.last_name).to_not eq(user[:last_name])
    expect(user_output.phone_number).to_not eq(user[:phone_number])
    expect(user_output.email).to_not eq(user[:email])
  end

  it 'returns json error message if user cannot be found' do
    body = {'first_name': 'Update', 'last_name': 'Update', 'phone_number': '9999999999', 'email': 'update@email.com'}

    patch "/api/v1/users/#{user.id}?api_key=c3f11ecd0c277a63ddf4", params: body.to_json, headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if user cannot be updated' do
    another_user = create(:user)

    # User trying to update email that is already in database
    body = {'email': "#{another_user.email}"}

    patch "/api/v1/users/#{user.id}?api_key=#{user.api_key}", params: body.to_json, headers: content_type

    expect(response).to have_http_status(422)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to update user')
  end

  it 'returns json updated user information with only one updated attribute' do
    body = {'first_name': 'Update'}

    patch "/api/v1/users/#{user.id}?api_key=#{user.api_key}", params: body.to_json, headers: content_type

    expect(response).to have_http_status(202)

    result = JSON.parse(response.body)

    user_output = User.last

    # Checks if user was successful updated to User table
    expect(user_output.first_name).to_not eq(user[:first_name])
    expect(user_output.first_name).to eq('Update')
    expect(user_output.last_name).to eq(user[:last_name])
    expect(user_output.phone_number).to eq(user[:phone_number])
    expect(user_output.email).to eq(user[:email])
  end
end
