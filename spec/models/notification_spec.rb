describe Notification do
  subject { FactoryGirl.build(:notification) }

  it 'has a contact_method' do
    subject.contact_method.should be_true
  end

  it 'is invalid without a contact_method' do
    FactoryGirl.build(:notification, contact_method: nil).should be_invalid
  end

  it 'has a alert' do
    subject.alert.should be_true
  end

  it 'is invalid without a alert' do
    FactoryGirl.build(:notification, alert: nil).should be_invalid
  end
end
