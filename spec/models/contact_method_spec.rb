describe ContactMethod do
  subject { FactoryGirl.build(:contact_method) }

  it 'has a label' do
    subject.label.should be_true
  end

  it 'has a type' do
    subject.type.should be_true
  end

  it 'has an address' do
    subject.address.should be_true
  end

  it 'has a user' do
    subject.user.should be_true
  end
end
