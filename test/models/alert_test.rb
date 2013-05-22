require 'test_helper'

class AlertTest < ActiveSupport::TestCase
  subject { FactoryGirl.build(:alert) }
  it 'has a description' do
    subject.description.wont_be_nil
  end
  it 'has details' do
    subject.details.wont_be_nil
  end
  it 'is invalid without a description' do
    subject.description = nil
    subject.valid?.wont_equal true
  end
end
