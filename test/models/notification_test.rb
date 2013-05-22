require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  subject { FactoryGirl.build(:notification) }
  it 'has a contact_method' do
    subject.contact_method.wont_be_nil
  end

  it 'is invalid without a contact_method' do
    subject.contact_method = nil
    subject.valid?.wont_equal true
  end

  it 'has a alert' do
    subject.alert.wont_be_nil
  end

  it 'is invalid without a alert' do
    subject.alert = nil
    subject.valid?.wont_equal true
  end
end
