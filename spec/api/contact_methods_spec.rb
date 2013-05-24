require "spec_helper"

describe "/api/v1/contact_methods", :type => :api do
  let(:contact_method) { create(:contact_method) }
  let(:url) { "/api/v1/contact_methods" }

  it 'should respond to #index' do
    get "#{url}.json"
    response.should be_ok
    response.body.should have_json_path('contact_methods')
  end

  it 'should respond to #show' do
    get "#{url}/#{contact_method.id}.json"
    response.should be_ok
    response.body.should have_json_path('contact_method')
  end

  it 'should respond to #update' do
    contact_method.label = 'test'
    put "#{url}/#{contact_method.id}.json", contact_method.as_json
    response.should be_successful
    ContactMethod.find(contact_method.id).label.should eq('test')
  end

  it 'should respond to #create' do
    post "#{url}.json", build(:contact_method, label: 'tardis').as_json
    response.should be_successful
    JSON.parse(response.body)['contact_method']['label'].should eq('tardis')
  end

  it 'should respond to #delete' do
    delete "#{url}/#{contact_method.id}.json", contact_method.as_json
    response.should be_successful
    ContactMethod.where(id: contact_method.id).should be_empty
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
