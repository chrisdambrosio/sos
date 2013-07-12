require 'spec_helper'

describe Schedule do
  subject { create(:schedule) }

  it { should validate_presence_of :name }
  it { should have_many :schedule_layers }
end
