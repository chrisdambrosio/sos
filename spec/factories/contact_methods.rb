FactoryGirl.define do
  factory :contact_method do
    label "mobile"
    type_id 0
    address "5555555555"
    user { User.new }
  end
end
