require 'rails_helper'

RSpec.describe Absence, type: :model do
  let(:teacher) { create(:user, :teacher) }
  let(:student) { create(:user, :student) }
  let(:lesson) { create(:lesson, teacher: teacher) }

  it '有効なabsenceを作成できること' do
    absence = Absence.new(user: student, lesson: lesson)
    expect(absence).to be_valid
  end

  it 'user_id と lesson_id の組み合わせは一意でなければならないこと' do
    create(:absence, user: student, lesson: lesson)
    duplicate_absence = Absence.new(user: student, lesson: lesson)
    expect(duplicate_absence).not_to be_valid
  end

  it 'userが必須であること' do
    absence = Absence.new(user: nil, lesson: lesson)
    expect(absence).not_to be_valid
  end

  it 'lessonが必須であること' do
    absence = Absence.new(user: student, lesson: nil)
    expect(absence).not_to be_valid
  end
end


