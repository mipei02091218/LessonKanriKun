FactoryBot.define do
  factory :user do
    name                  { '山田太郎' }
    name_kana             { 'ヤマダタロウ' }
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { 'abc123' }
    role                  { 'student' }
  end

  factory :teacher, class: 'User' do
    name                  { '鈴木奈々' }
    name_kana             { 'スズキナナ' } 
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { 'abc123' }
    role                  { 'teacher' }
  end
end