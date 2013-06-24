require "spec_helper"

describe "/api/v1/alerts", :contact_type => :api do
  let(:user) { create(:user) }
  let(:alert) { create(:alert, assigned_to: user) }
  let(:base_url) { "/api/v1/alerts" }

  it 'should respond to #index' do
    get "#{base_url}.json"
    response.should be_ok
    response.body.should have_json_path('alerts')
  end

  it 'should respond to #show' do
    get "#{base_url}/#{alert.id}.json"
    response.should be_ok
    response.body.should have_json_path('alert')
  end

  it 'should respond to #update' do
    alert.description = 'new description'
    put "#{base_url}/#{alert.id}.json", AlertSerializer.new(alert).as_json
    response.should be_successful
    Alert.find(alert.id).description.should eq('new description')
  end

  it 'should respond to #create' do
    json = AlertSerializer.new(
      build(:alert, description: 'tardis', assigned_to: user)
    ).as_json
    post "#{base_url}.json", json
    response.should be_successful
    JSON.parse(response.body)['alert']['description'].should eq('tardis')
    JSON.parse(response.body)['alert']['assigned_to'].should eq(user.id)
  end

  it 'should respond to #delete' do
    delete "#{base_url}/#{alert.id}.json"#, contact_method.as_json
    response.should be_successful
    Alert.where(id: alert.id).should be_empty
  end

  it 'should respond to 404' do
    get "#{base_url}/nil.json"
    response.should be_not_found
  end

  it 'should handle server errors' do
    post "#{base_url}.json", '{ this is not real json }'
    response.should be_error
  end
end
