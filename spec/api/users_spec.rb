require "spec_helper"

describe "/api/v1/users", :type => :api do
  let(:user) { create(:user) }
  let(:url) { "/api/v1/users" }

  it 'should respond to #index' do
    get "#{url}.json"
    response.should be_ok
    response.body.should have_json_path('users')
  end

  it 'should respond to #show' do
    get "#{url}/#{user.id}.json"
    response.should be_ok
    response.body.should have_json_path('user')
  end

  it 'should respond to #update' do
    user.name = 'test'
    put "#{url}/#{user.id}.json", user.as_json
    response.should be_successful
    User.find(user.id).name.should eq('test')
  end

  it 'should respond to #create' do
    post "#{url}.json", build(:user, name: 'tardis').as_json
    response.should be_successful
    JSON.parse(response.body)['user']['name'].should eq('tardis')
  end

  it 'should respond to #delete' do
    delete "#{url}/#{user.id}.json", user.as_json
    response.should be_successful
    User.where(id: user.id).should be_empty
  end

  it 'should respond to 404' do
    get "#{url}/nil.json"
    response.should be_not_found
  end

  it 'should handle server errors' do
    post "#{url}.json", '{ this is not real json }'
    response.should be_error
  end
end
