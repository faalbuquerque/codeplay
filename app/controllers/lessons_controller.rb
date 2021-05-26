class LessonsController < ApplicationController
  before_action :set_course, only: %i[show new create edit update destroy]

  def show
    @lesson = @course.lessons.find_by(id: params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    msg = t('.success')
    return redirect_to @course, notice: msg if @lesson.save

    render :new
  end

  def edit
    @lesson = @course.lessons.find_by(id: params[:id])
  end

  def update
    msg = t('.success')
    @lesson = @course.lessons.find_by(id: params[:id])
    return redirect_to @course, notice: msg if @lesson.update(lesson_params)

    render :edit
  end

  def destroy
    msg = t('.success')
    @lesson = @course.lessons.find_by(id: params[:id])
    return redirect_to @course, notice: msg if @lesson and @lesson.destroy

    redirect_to @course, alert: t('lesson_not_available')
  end

  private

  def set_course
    @course = Course.find_by(id: params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :duration, :content)
  end
end