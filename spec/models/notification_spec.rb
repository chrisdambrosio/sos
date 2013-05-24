describe Notification do
  subject { FactoryGirl.build(:notification) }

  it 'has a contact_method' do
    subject.contact_method.should be_true
  end

  it 'has an alert' do
    subject.alert.should be_true
  end

  it { should validate_presence_of :alert }
  it { should validate_presence_of :contact_method }
  it { should belong_to :contact_method }
  it { should belong_to :alert }
end
