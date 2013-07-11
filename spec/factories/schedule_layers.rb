FactoryGirl.define do
  factory :schedule_layer do
    start_time          { Time.utc(2013,7,8) }
    priority            0
    rotation_duration   86400
  end
end
