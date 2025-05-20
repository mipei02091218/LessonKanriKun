require 'rails_helper'

RSpec.describe "Absences", type: :request do
  let(:lesson) { create(:lesson, teacher: create(:teacher)) }
  let(:student) { create(:user, role: 'student') }

  before do
    sign_in student
  end

  describe "POST /lessons/:lesson_id/absences" do
    it "ログインしている生徒が欠席登録できる" do
      expect {
        post lesson_absences_path(lesson_id: lesson.id)
      }.to change(Absence, :count).by(1)

      expect(response).to redirect_to(lessons_path)
    end
  end

  describe "DELETE /lessons/:lesson_id/absences/:id" do
    let!(:absence) { create(:absence, lesson: lesson, user: student) }

    it "欠席登録を削除できる" do
      expect {
        delete lesson_absence_path(lesson_id: lesson.id, id: absence.id)
      }.to change(Absence, :count).by(-1)

      expect(response).to redirect_to(lessons_path)
    end
  end
end
