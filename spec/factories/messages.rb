FactoryBot.define do
  factory :message do
    subject { "MyString" }
    body { "MyText" }
    read { false }
    sender { nil }
    receiver { nil }
  end
end
