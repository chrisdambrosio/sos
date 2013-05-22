require 'test_helper'

class ContactMethodTest < ActiveSupport::TestCase
  subject { FactoryGirl.build(:contact_method) }

  it 'has a label' do
    subject.label.must_be_kind_of String
  end

  it 'has a type' do
    subject.type.must_be_instance_of Symbol
  end

  it 'has an address' do
    subject.type.wont_be_nil
  end

  it 'has a user' do
    subject.user.wont_be_nil
  end
end
