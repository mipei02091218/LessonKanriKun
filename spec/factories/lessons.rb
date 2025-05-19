FactoryBot.define do
  factory :lesson do
    association :teacher, factory: :teacher
    start_time { 1.day.from_now}
  end
end
