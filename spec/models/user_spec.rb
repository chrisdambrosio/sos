require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }

  it 'has a name' do
    subject.name.should be_true
  end

  it 'has a email' do
    subject.email.should be_true
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should have_many :contact_methods }
end
