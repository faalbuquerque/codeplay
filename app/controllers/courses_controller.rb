class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    msg = t('.success')
    return redirect_to @course, notice: msg if @course.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    msg = t('.success')
    return redirect_to @course, notice: msg if @course.update(course_params)

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
                                   :enrollment_deadline)
  end

  def set_course
    @course = Course.find_by(id: params[:id])
  end
end
