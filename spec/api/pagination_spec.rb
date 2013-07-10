require "spec_helper"

describe "pagination offset/limit/count", :type => :api do
  before do
    @user_count = 6
    @user_count.times do
      create :user,
        { name: Faker::Name.name, email: Faker::Internet.email }
    end
    @users = User.all.order(created_at: :asc)
  end

  it 'should have the correct total in json' do
    get "/api/v1/users.json"
    total = JSON.parse(response.body)['meta']['total']
    expect(total).to eq(@user_count)
  end

  it 'should implement the limit parameter' do
    get "/api/v1/users.json?limit=5"
    limit = JSON.parse(response.body)['users'].count
    expect(limit).to eq(5)
  end

  it 'should show the limit in json' do
    get "/api/v1/users.json?limit=5"
    limit = JSON.parse(response.body)['meta']['limit']
    expect(limit).to eq(5)
  end

  it 'should set the limit to 100 by default' do
    get "/api/v1/users.json"
    limit = JSON.parse(response.body)['meta']['limit']
    expect(limit).to eq(100)
  end

  it 'should implement the offset parameter' do
    get "/api/v1/users.json?offset=4"
    users = JSON.parse(response.body)['users']
    expect(users[0]['id']).to eq(@users[@users.count - 5].id)
  end

  it 'should show the offset in json' do
    get "/api/v1/users.json?offset=5"
    offset = JSON.parse(response.body)['meta']['offset']
    expect(offset).to eq(5)
  end

  it 'should set the offset to 0 by default' do
    get "/api/v1/users.json"
    offset = JSON.parse(response.body)['meta']['offset']
    expect(offset).to eq(0)
  end

  it 'should order by an attribute' do
    get "/api/v1/users.json?sort_by=id&order=desc"
    user = JSON.parse(response.body)['users'].first
    expect(user['id']).to eq(@users.last.id)
  end
end
