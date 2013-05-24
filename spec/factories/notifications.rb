FactoryGirl.define do
  factory :notification do
    contact_method { FactoryGirl.build(:contact_method) }
    alert { FactoryGirl.build(:alert) }
  end
end
