FactoryBot.define do
  factory :absence do
    association :user
    association :lesson
  end
end
