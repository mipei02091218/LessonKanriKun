class AbsencesController < ApplicationController

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @absence = @lesson.absences.build(user: current_user)

    if @absence.save
      redirect_to lessons_path, notice: "欠席を登録しました"
    else
      redirect_to lessons_path, alert: "すでに欠席登録済みです"
    end
  end

  def destroy
    @lesson = Lesson.find(params[:lesson_id])
    @absence = @lesson.absences.find_by(user: current_user)
    
    if @absence.destroy
      redirect_to lessons_path, notice: "欠席を取り消しました"
    end
  end

end
