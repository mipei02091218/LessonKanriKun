class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:edit, :update]
  before_action :authorize_teacher!, only: [:new, :create, :edit, :update]

  def index
    @lessons = Lesson.all
  end

  def new
    @lesson = Lesson.new
  end

  def create
    if current_user.teacher?
      @lesson = current_user.lessons.build(lesson_parameter)
      if @lesson.save
        redirect_to lessons_path, notice: "レッスンを登録しました"
      else
        render :new
      end
    else
      redirect_to lessons_path, alert: '生徒はレッスンを登録できません'
    end      
  end

  def edit
    @lesson = Lesson.find(params[:id])
    unless current_user.teacher? && @lesson.teacher == current_user
      redirect_to lessons_path, alert: '編集できるのは先生のみです'
    end
  end

  def update
    lesson = Lesson.find(params[:id])
    if current_user.teacher? && @lesson.teacher == current_user
      if lesson.update(lesson_parameter)
        redirect_to lessons_path
      else
        render :edit
      end
    else
      redirect_to lessons_path, alert: '編集できるのは先生のみです'
    end
  end

  def destroy
    lesson = Lesson.find(params[:id])
    if current_user.teacher? && lesson.teacher == current_user
      lesson.destroy
      redirect_to lessons_path
    end
  end

  private

  def lesson_parameter
    params.require(:lesson).permit(:start_time)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def authorize_teacher!
    unless current_user.teacher? && (@lesson.nil? || @lesson.teacher == current_user)
      redirect_to lessons_path, alert: '操作できるのは先生のみです'
    end
  end

end