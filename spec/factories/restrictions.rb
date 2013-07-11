FactoryGirl.define do
  factory :restriction do
    start_day_of_week 'monday'
    end_day_of_week   'wednesday'
    start_time_of_day '13:37'
    end_time_of_day   '14:47'
    schedule_layer    { create(:schedule_layer) }
  end
end
