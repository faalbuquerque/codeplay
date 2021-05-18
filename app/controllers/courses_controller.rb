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
    @course = Course.find(params[:id])
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
    @course = Course.find(params[:id])
    return redirect_to courses_path if @course.destroy!

    render courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline)
  end
end
