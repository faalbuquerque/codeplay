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
    return redirect_to @course if @course.save

    render :new
  end

  def show
    msg = 'Oops, curso não disponivel!'

    redirect_to courses_path, notice: msg unless @course
  end

  def edit
  end

  def update
    return redirect_to @course if @course.update(course_params)

    render :edit
  end

  def destroy
    msg = 'Curso apagado com sucesso!'
    return redirect_to courses_path, notice: msg if @course and @course.delete

    redirect_to courses_path, notice: 'Oops, curso não disponivel!'
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
