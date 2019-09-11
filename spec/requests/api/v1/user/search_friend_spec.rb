require 'rails_helper'

describe 'Search Friend Show', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  it 'returns json friend object information' do
    get "/api/v1/user/search?api_key=#{user.api_key}&query=#{friend.first_name} #{friend.last_name}", headers: content_type

    expect(response).to have_http_status(200)

    result = JSON.parse(response.body)

    # Checks response JSON API 1.0 Compliant
    expect(result).to have_key('data')
    expect(result['data']).to have_key('id')
    expect(result['data']['id']).to eq(friend.id.to_s)
    expect(result['data']).to have_key('type')
    expect(result['data']['type']).to eq('search_friend')
    expect(result['data']).to have_key('attributes')
    # Checks the return user's information
    expect(result['data']['attributes']).to have_key('name')
    expect(result['data']['attributes']).to have_key('phone_number')
    expect(result['data']['attributes']).to have_key('email')
    expect(result['data']['attributes']['name']).to eq("#{friend.first_name} #{friend.last_name}")
    expect(result['data']['attributes']['phone_number']).to eq(friend.phone_number)
    expect(result['data']['attributes']['email']).to eq(friend.email)
  end

  it 'returns json friend object information if query name is upcased' do
    get "/api/v1/user/search?api_key=#{user.api_key}&query=#{friend.first_name.upcase} #{friend.last_name.upcase}", headers: content_type

    expect(response).to have_http_status(200)
  end

  it 'returns json error message if user cannot be found' do
    get "/api/v1/user/search?api_key=kjSdf!hs?Sj&query=#{friend.first_name} #{friend.last_name}", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to find user')
  end

  it 'returns json error message if event cannot be found' do
    get "/api/v1/user/search?api_key=#{user.api_key}&query=Bob", headers: content_type

    expect(response).to have_http_status(404)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('User is not in database')
  end
end
