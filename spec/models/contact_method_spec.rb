describe ContactMethod do
  subject { FactoryGirl.build(:contact_method) }

  it 'has a label' do
    subject.label.should be_true
  end

  it 'has a contact_type' do
    subject.contact_type.should be_true
  end

  it 'has an address' do
    subject.address.should be_true
  end

  it 'has a user' do
    subject.user.should be_true
  end

  it { should belong_to :user }
end
