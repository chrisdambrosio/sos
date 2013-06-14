describe NotificationRule do
  subject { FactoryGirl.build(:notification_rule) }

  it 'has a start_delay' do
    subject.start_delay.should be_true
  end

  it { should belong_to :contact_method }
end
