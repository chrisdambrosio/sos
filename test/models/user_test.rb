require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { FactoryGirl.build(:user) }

  it 'should have a name' do
    subject.name.wont_be_nil
  end

  it 'should be invalid without a name' do
    subject.name = nil
    subject.valid?.wont_equal true
  end

  it 'should have an email address' do
    subject.email.wont_be_nil
  end

  it 'should be invalid without a email address' do
    subject.email = nil
    subject.valid?.wont_equal true
  end
end
