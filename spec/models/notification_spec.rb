describe Notification do
  subject { FactoryGirl.build(:notification) }

  it 'has a user' do
    subject.user.should be_true
  end

  it 'has an alert' do
    subject.alert.should be_true
  end

  it { should validate_presence_of :alert }
  it { should validate_presence_of :user }
  it { should belong_to :user }
  it { should belong_to :alert }
end
