require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }

  it 'has a name' do
    subject.name.should be_true
  end
end
