require 'rails_helper'

RSpec.describe "Lessons", type: :request do
  let(:teacher) { create(:user, role: 'teacher') }
  let(:student) { create(:user, role: 'student') }
  let(:lesson) { create(:lesson, teacher: teacher) }

  before do

  end

  describe "POST /lessons" do
    context "先生としてログインしている場合" do
      before { sign_in teacher }

      it "レッスンを作成できる" do
        expect {
          post lessons_path, params: {
            lesson: {
              start_time: Time.current + 1.day
            }
          }
        }. to change(Lesson, :count).by(1)

        expect(response).to redirect_to(lessons_path)
      end
    end

    context "生徒としてログインしている場合" do
      before { sign_in student }

      it "レッスンを作成できずリダイレクトされる" do
        expect {
          post lessons_path, params: {
            lesson: {
              start_time: Time.current + 1.day
            }
          }
        }.to_not change(Lesson, :count)
      
        expect(response).to redirect_to(lessons_path)
      end
    end
  end

  describe "PATCH /lesson/:id" do
    context "先生としてログインしている場合" do
      before { sign_in teacher }
     
      it "レッスンを編集できる" do
        new_time = Time.current + 2.days
        patch lesson_path(lesson), params: { lesson: {start_time: new_time } }

        expect(response).to redirect_to(lessons_path)
        expect(lesson.reload.start_time.to_date).to eq(new_time.to_date)
      end
    end

    context"生徒としてログインしている場合" do
      before { sign_in student }

      it "編集できずリダイレクトされる" do
        patch lesson_path(lesson), params: { lesson: {start_time: Time.current + 2.days } }

        expect(response).to redirect_to (lessons_path)
      end
    end
  end

  describe "DELETE /lessons/:id" do
    context "先生としてログインしている場合" do
      before { sign_in teacher}

      it "レッスンを削除できる" do
        lesson_to_delete = create(:lesson, teacher: teacher)

        expect{
          delete lesson_path(lesson_to_delete)
        }.to change(Lesson, :count).by(-1)

        expect(response).to redirect_to(lessons_path)
      end
    end

    context "生徒としてログインしている場合" do
      before { sign_in student }

      it "削除できずリダイレクトされる" do
        delete lesson_path(lesson)

        expect(response).to redirect_to(lessons_path)
        expect(Lesson.exists?(lesson.id)).to be true
      end
    end
  end
end
