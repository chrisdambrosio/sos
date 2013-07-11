require 'spec_helper'

describe 'Scheduling Integration' do
  before do
    @schedule_layer1 = create(:schedule_layer)
    @user1 = create(:user)
    @user2 = create(:user)
    @user_schedule1 = create(:user_schedule,
      schedule_layer: @schedule_layer1, position: 0, user: @user1)
    @user_schedule2 = create(:user_schedule,
      schedule_layer: @schedule_layer1, position: 1, user: @user2)
    @entries = @schedule_layer1.timeline_entries(
      Time.utc(2013,7,8), Time.utc(2013,7,15))
  end

  it 'has the correct schedule entries' do
    expect(@entries.count).to eq(7)
  end

  describe 'restrictions' do
    before do
      @restriction = create(:restriction, schedule_layer: @schedule_layer1)
      @schedule_layer1.reload
      @entries = @restriction.schedule_layer.timeline_entries(
        Time.utc(2013,7,8), Time.utc(2013,7,15)
      )
    end

    it 'handles day of week restrictions' do
      expect(@entries.count).to eq(3)
    end

    it 'has a user for each restriction' do
      @entries.each do |entry|
        expect(entry.user).not_to be_nil
      end
    end
  end
end
