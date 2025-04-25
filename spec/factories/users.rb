FactoryBot.define do
  factory :user do
    name                  { '山田太郎' }
    name_kana             { 'ヤマダタロウ' }
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { 'abc123' }
    role                  { 'student' }
  end
end
