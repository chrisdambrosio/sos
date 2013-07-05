FactoryGirl.define do
  factory :contact_method do
    label "mobile"
    contact_type "sms"
    address "5555555555"
    user { create(:user, name: Faker::Name.name, email: Faker::Internet.email) }
  end
end
