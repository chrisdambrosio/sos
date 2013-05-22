# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    description "system error"
    details "there is a system error"
  end
end
