FactoryGirl.define do
  factory :contact_method do
    label "mobile"
    contact_type "sms"
    address "5555555555"
    user { User.new }
  end
end
