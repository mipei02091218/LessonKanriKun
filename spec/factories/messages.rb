FactoryBot.define do
  factory :message do
    association :sender, factory: :user
    association :receiver, factory: :teacher

    subject { "テスト件名" }
    body { "テスト本文" }
    read { false }
  end
end
