require "spec_helper"

describe "/api/v1/schedules", :type => :api do
  let(:schedule) { create(:schedule) }
  let(:url) { "/api/v1/schedules" }

  it 'should respond to #index' do
    get "#{url}.json"
    response.should be_ok
    response.body.should have_json_path('schedules')
  end

  it 'should respond to #show' do
    get "#{url}/#{schedule.id}.json"
    response.should be_ok
    response.body.should have_json_path('schedule')
  end

  it 'should respond to 404' do
    get "#{url}/nil.json"
    response.should be_not_found
  end
end
