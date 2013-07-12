require 'spec_helper'

describe UserSchedule do
  subject { create(:user_schedule) }

  it { should validate_presence_of :position }
  it { should belong_to(:schedule_layer) }
  it { should validate_presence_of :user }

  describe '#timeline_entries' do
    before do
      @entries = subject.timeline_entries(Time.utc(2013,7,8), Time.utc(2013,7,15))
    end

    it 'returns timeline entries' do
      expect(@entries[0]).to be_kind_of(TimelineEntry)
      expect(@entries.count).to eq(7)
    end

    it 'returns the correct quantity' do
      expect(@entries.count).to eq(7)
    end

    it 'returns the correct quantity with rotation interval of 2' do
      create(:user_schedule, position: 1, schedule_layer: subject.schedule_layer)
      entries = subject.timeline_entries(Time.utc(2013,7,8), Time.utc(2013,7,15))
      expect(entries.count).to eq(4)
    end

    it 'has a user' do
      expect(@entries[0].user).to be_a(User)
    end
  end
end
