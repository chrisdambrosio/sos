require 'spec_helper'

describe Alert do
  subject { FactoryGirl.build(:alert) }

  it 'has a description' do
    subject.description.should be_true
  end

  it 'has details' do
    subject.details.should be_true
  end

  it { should validate_presence_of :description }
end
