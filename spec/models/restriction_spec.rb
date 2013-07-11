require 'spec_helper'

describe Restriction do
  subject { create(:restriction) }

  describe '#restriction_entries' do
    it 'creates restriction_entries' do
      @entries = subject.restriction_entries(Time.new(2013,5,7), Time.new(2013,5,15))
      expect(@entries[0]).to be_kind_of(RestrictionEntry)
    end
  end
end
