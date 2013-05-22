# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    contact_method FactoryGirl.build(:contact_method)
    alert FactoryGirl.build(:alert)
  end
end
