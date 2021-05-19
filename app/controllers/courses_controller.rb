class CoursesController < ApplicationController

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
    @course = Course.find_by(id: params[:id])
    msg = 'Oops, curso não disponivel!'

    redirect_to courses_path, notice: msg unless @course
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    return redirect_to @course if @course.update(course_params)

    render :edit
  end

  def destroy
    @course = Course.find_by(id: params[:id])
    msg = 'Curso apagado com sucesso!'
    return redirect_to courses_path, notice: msg if @course and @course.delete

    redirect_to courses_path, notice: 'Oops, curso não disponivel!'
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :code, :price,
                                   :enrollment_deadline)
  end
end
