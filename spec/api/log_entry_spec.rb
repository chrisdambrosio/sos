require "spec_helper"

describe "/api/v1/:alert/log_entries", :contact_type => :api do
  let(:user) { create(:user) }
  let(:alert) { create(:alert, assigned_to: user) }
  let(:base_url) { "/api/v1/alerts/#{alert.id}/log_entries" }

  it 'should respond to #index' do
    get "#{base_url}.json"
    response.should be_ok
    response.body.should have_json_path('log_entries')
  end
end
