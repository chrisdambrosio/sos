require 'spec_helper'

describe ScheduleLayer do
  subject { FactoryGirl.build(:schedule_layer) }

  it { should validate_presence_of :start_time }
  it { should validate_presence_of :rotation_duration }
  it { should have_many(:user_schedules) }

  describe '#timeline_entries' do
    before do
      user_schedule1 = create :user_schedule,
        schedule_layer: subject, position: 0, user: build(:user)
      user_schedule2 = create :user_schedule,
        schedule_layer: subject, position: 1, user: build(:user)
      @entries = subject.timeline_entries(Time.new(2013,7,8), Time.new(2013,7,15))
    end

    it 'returns timeline entries' do
      expect(@entries[0]).to be_kind_of(TimelineEntry)
    end
  end
end
