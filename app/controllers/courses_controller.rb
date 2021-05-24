class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @teachers = Teacher.all
    @courses = Course.all
  end

  def new
    @teachers = Teacher.all
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    msg = t('.success')
    return redirect_to @course, notice: msg if @course.save

    @teachers = Teacher.all
    render :new
  end

  def show
  end

  def edit
    @teachers = Teacher.all
  end

  def update
    msg = t('.success')
    return redirect_to @course, notice: msg if @course.update(course_params)

    @teachers = Teacher.all
    render :edit
  end

  def destroy
    msg = t('.success')
    return redirect_to courses_path, notice: msg if @course and @course.delete

    redirect_to courses_path, alert: t('course_not_available')
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :code, :price,
                                   :enrollment_deadline, :teacher_id)
  end

  def set_course
    @course = Course.find_by(id: params[:id])
  end
end
