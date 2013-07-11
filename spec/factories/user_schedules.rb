# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_schedule do
    schedule_layer { create(:schedule_layer) }
    position 0
    user { build(:user) }
  end
end
