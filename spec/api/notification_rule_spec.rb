require "spec_helper"

describe "/api/v1/:users/notification_rules", :type => :api do
  let(:user) { create(:user) }
  let(:contact_method) { create(:contact_method, user: user) }
  let(:notification_rule) { create(:notification_rule, contact_method: contact_method) }
  let(:base_url) { "/api/v1/users/#{user.id}/notification_rules" }

  it 'should respond to #index' do
    get "#{base_url}.json"
    response.should be_ok
    response.body.should have_json_path('notification_rules')
  end

  it 'should respond to #show' do
    get "#{base_url}/#{notification_rule.id}.json"
    response.should be_ok
    response.body.should have_json_path('notification_rule')
  end

  it 'should respond to #update' do
    notification_rule.start_delay = 23
    put "#{base_url}/#{notification_rule.id}.json", notification_rule.as_json
    response.should be_successful
    NotificationRule.find(notification_rule.id).start_delay.should eq(23)
  end

  it 'should respond to #create' do
    post "#{base_url}.json", build(
      :notification_rule, contact_method: contact_method, start_delay: 42
    ).as_json
    response.should be_successful
    JSON.parse(response.body)['notification_rule']['start_delay'].should eq(42)
  end

  it 'should respond to #delete' do
    delete "#{base_url}/#{notification_rule.id}.json", notification_rule.as_json
    response.should be_successful
    NotificationRule.where(id: notification_rule.id).should be_empty
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
