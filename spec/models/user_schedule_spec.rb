require 'spec_helper'

describe UserSchedule do
  subject { create(:user_schedule) }

  it { should validate_presence_of :position }
  it { should belong_to(:schedule_layer) }
  it { should validate_presence_of :user }

  describe '#timeline_entries' do
    it 'returns timeline entries' do
      entries = subject.timeline_entries(Time.new(2013,7,8), Time.new(2013,7,15))
      expect(entries[0].class).to eq(TimelineEntry)
      expect(entries.count).to eq(7)
    end

    it 'returns the correct quantity' do
      entries = subject.timeline_entries(Time.new(2013,7,8), Time.new(2013,7,15))
      expect(entries.count).to eq(7)
    end

    it 'returns the correct quantity with rotation interval of 2' do
      create(:user_schedule, position: 1, schedule_layer: subject.schedule_layer)
      entries = subject.timeline_entries(Time.new(2013,7,8), Time.new(2013,7,15))
      expect(entries.count).to eq(4)
    end
  end
end
